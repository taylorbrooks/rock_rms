module RockRMS
  module Response
    class RecurringDonation < Base
      MAP = {
        active: 'IsActive',
        financial_gateway_id: 'FinancialGatewayId',
        frequency: 'TransactionFrequencyValueId',
        end_date: 'EndDate',
        gateway_schedule_id: 'GatewayScheduleId',
        next_payment_date: 'NextPaymentDate',
        number_of_payments: 'NumberOfPayments',
        payment_details: 'FinancialPaymentDetail',
        person_id: 'AuthorizedPersonAliasId',
        previous_gateway_schedule_ids: 'PreviousGatewayScheduleIdsJson',
        start_date: 'StartDate',
        transaction_details: 'ScheduledTransactionDetails',
        transaction_code: 'TransactionCode',
        transaction_type_id: 'TransactionTypeValueId',
        summary: 'Summary',
        status: 'Status',
        status_message: 'StatusMessage',
      }.freeze

      def format_single(data)
        result = to_h(MAP, data)
        result[:frequency]           = find_frequency_by_id(result[:frequency])
        result[:transaction_details] = RecurringDonationDetails.format(result[:transaction_details])
        result[:payment_details]     = PaymentDetail.format(result[:payment_details])
        result
      end

      def find_frequency_by_id(type_id)
        RecurringFrequencies::RECURRING_FREQUENCIES.key(type_id)
      end
    end
  end
end

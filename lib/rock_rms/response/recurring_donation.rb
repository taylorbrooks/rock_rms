module RockRMS
  module Response
    class RecurringDonation < Base
      MAP = {
        id: 'Id',
        active: 'IsActive',
        financial_gateway_id: 'FinancialGatewayId',
        foreign_key: 'ForeignKey',
        frequency: 'TransactionFrequencyValueId',
        end_date: 'EndDate',
        gateway_schedule_id: 'GatewayScheduleId',
        next_payment_date: 'NextPaymentDate',
        payment_details: 'FinancialPaymentDetail',
        person_id: 'AuthorizedPersonAliasId',
        start_date: 'StartDate',
        transaction_details: 'ScheduledTransactionDetails',
        transaction_code: 'TransactionCode',
        transaction_type_id: 'TransactionTypeValueId',
        summary: 'Summary'
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

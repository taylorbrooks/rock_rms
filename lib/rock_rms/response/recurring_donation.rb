module RockRMS
  module Response
    class RecurringDonation < Base
      MAP = {
        id: 'Id',
        active: 'IsActive',
        foreign_key: 'ForeignKey',
        next_payment_date: 'NextPaymentDate',
        payment_details: 'FinancialPaymentDetail',
        person_id: 'AuthorizedPersonAliasId',
        transaction_details: 'ScheduledTransactionDetails',
        transaction_code: 'TransactionCode'
      }.freeze

      def format_single(data)
        result = to_h(MAP, data)
        result[:transaction_details] = RecurringDonationDetails.format(result[:transaction_details])
        result[:payment_details]     = PaymentMethod.format(result[:payment_details])
        result
      end
    end
  end
end

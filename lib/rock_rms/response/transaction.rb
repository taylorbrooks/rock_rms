module RockRMS
  module Response
    class Transaction < Base
      MAP = {
        date: 'TransactionDateTime',
        person: 'AuthorizedPersonAlias',
        person_id: 'AuthorizedPersonAliasId',
        batch_id: 'BatchId',
        gateway_id: 'FinancialGatewayId',
        recurring_donation_id: 'ScheduledTransactionId',
        summary: 'Summary',
        transaction_code: 'TransactionCode',
        details: 'TransactionDetails',
        payment_details: 'FinancialPaymentDetail',
        payment_detail_id: 'FinancialPaymentDetailId',
        transaction_type_id: 'TransactionTypeValueId',
        source_type_id: 'SourceTypeValueId',
      }.freeze


      def format_single(data)
        response                   = to_h(MAP, data)
        response[:details]         = TransactionDetail.format(response[:details])
        response[:payment_details] = PaymentDetail.format(response[:payment_details])
        response[:person]          = format_person(response[:person])
        response[:amount]          = calculate_total(response[:details])
        response
      end

      def format_person(res)
        return res if res.nil?

        Person.format(res['Person'])
      end

      def calculate_total(details)
        details.reduce(0) { |sum, td| sum + td[:amount] }
      end
    end
  end
end

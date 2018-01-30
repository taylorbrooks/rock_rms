module RockRMS
  module Response
    class Transaction < Base
      MAP = {
        id: 'Id',
        date: 'TransactionDateTime',
        person_id: 'AuthorizedPersonAliasId',
        batch_id: 'BatchId',
        recurring_donation_id: 'ScheduledTransactionId',
        summary: 'Summary',
        transaction_code: 'TransactionCode',
        details: 'TransactionDetails'
      }.freeze


      def format_single(data)
        response           = to_h(MAP, data)
        response[:details] = TransactionDetail.format(response[:details])
        response[:amount]  = calculate_total(response[:details])
        response
      end

      def calculate_total(details)
        details.reduce(0) { |sum, td| sum + td[:amount] }
      end
    end
  end
end

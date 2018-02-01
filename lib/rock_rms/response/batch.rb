module RockRMS
  module Response
    class Batch < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        control_amount: 'ControlAmount',
        transactions: 'Transactions'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:transactions] = Transaction.format(response[:transactions])
        response[:amount]       = calculate_total(response[:transactions])
        response
      end

      def calculate_total(transactions)
        transactions.reduce(0) { |sum, txn| sum + txn[:amount] }
      end
    end
  end
end

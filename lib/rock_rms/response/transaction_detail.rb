module RockRMS
  module Response
    class TransactionDetail < Base
      MAP = {
        id: 'Id',
        fund_id: 'AccountId',
        amount: 'Amount'
      }.freeze

      def format_single(response)
        to_h(MAP, response)
      end
    end
  end
end

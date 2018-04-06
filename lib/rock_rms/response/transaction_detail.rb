module RockRMS
  module Response
    class TransactionDetail < Base
      MAP = {
        id: 'Id',
        fund: 'Account',
        fund_id: 'AccountId',
        amount: 'Amount'
      }.freeze

      def format_single(response)
        response        = to_h(MAP, response)
        response[:fund] = Fund.format(response[:fund])
        response
      end
    end
  end
end

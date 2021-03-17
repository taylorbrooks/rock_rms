module RockRMS
  module Response
    class TransactionDetail < Base
      MAP = {
        id: 'Id',
        fee_amount: 'FeeAmount',
        fund: 'Account',
        fund_id: 'AccountId',
        amount: 'Amount',
        entity_type_id: 'EntityTypeId',
        entity_id: 'EntityId'
      }.freeze

      def format_single(response)
        response        = to_h(MAP, response)
        response[:fund] = Fund.format(response[:fund])
        response
      end
    end
  end
end

module RockRMS
  module Response
    class RecurringDonationDetails < Base
      MAP = {
        id: 'Id',
        amount: 'Amount',
        fund_id: 'AccountId',
        entity_type_id: 'EntityTypeId',
        entity_id: 'EntityId'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

module RockRMS
  module Response
    class AttributeValue < Base
      MAP = {
        id: 'Id',
        value: 'Value',
        value_as_number: 'ValueAsNumeric',
        entity_id: 'EntityId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

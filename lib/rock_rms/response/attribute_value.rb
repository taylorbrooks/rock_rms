module RockRMS
  module Response
    class AttributeValue < Base
      MAP = {
        value: 'Value',
        value_as_number: 'ValueAsNumeric',
        value_formatted: 'ValueFormatted',
        entity_id: 'EntityId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

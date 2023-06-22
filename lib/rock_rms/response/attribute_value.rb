module RockRMS
  module Response
    class AttributeValue < Base
      MAP = {
        value: 'Value',
        value_as_number: 'ValueAsNumeric',
        value_formatted: 'ValueFormatted',
        entity_id: 'EntityId',
        attribute: 'Attribute',
      }.freeze

      def format_single(data)
        to_h(MAP, data)

        response                   = to_h(MAP, data)
        response[:attribute]       = Attribute.format(response[:attribute])
        response
      end

    end
  end
end

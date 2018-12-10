module RockRMS
  module Response
    class DefinedType < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        description: 'Description',
        defined_values: 'DefinedValues',
        order: 'Order',
        value: 'Value',
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:defined_values] = DefinedValue.format(response[:defined_values])
        response
      end
    end
  end
end

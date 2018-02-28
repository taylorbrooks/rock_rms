module RockRMS
  module Response
    class DefinedValue < Base
      MAP = {
        id: 'Id',
        defined_type_id: 'DefinedTypeId',
        description: 'Description',
        order: 'Order',
        value: 'Value',
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

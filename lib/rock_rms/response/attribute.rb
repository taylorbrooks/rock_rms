module RockRMS
  module Response
    class Attribute < Base
      MAP = {
        name: 'Name',
        key: 'Key',
        description: 'Description',
        entity_type_id: 'EntityTypeId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

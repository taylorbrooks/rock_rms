module RockRMS
  class Client
    module EntityType
      PATH = 'EntityTypes'.freeze

      def list_entity_types(options = {})
        res = get(entity_type_path, options)
        Response::EntityType.format(res)
      end

      def find_entity_type(id)
        res = get(entity_type_path(id))
        Response::EntityType.format(res)
      end

      private

      def entity_type_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

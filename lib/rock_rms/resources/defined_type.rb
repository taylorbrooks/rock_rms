module RockRMS
  class Client
    module DefinedType
      def list_defined_types(options = {})
        Response::DefinedType.format(
          get(defined_types_path, options)
        )
      end

      def find_defined_type(id)
        Response::DefinedType.format(get(defined_types_path(id)))
      end

      private

      def defined_types_path
        'DefinedTypes'.freeze
      end
    end
  end
end

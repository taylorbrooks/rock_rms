module RockRMS
  class Client
    module AttributeValue
      def list_attribute_values(options = {})
        Response::AttributeValue.format(
          get(attribute_values_path, options)
        )
      end

      def create_attribute_value(attribute_id:, entity_id:, value:)
        options = {
          'AttributeId' => attribute_id,
          'EntityId'    => entity_id,
          'Value'       => value,
          'IsSystem'    => false
        }

        post(attribute_values_path, options)
      end

      private

      def attribute_values_path
        'AttributeValues'.freeze
      end
    end
  end
end

module RockRMS
  class Client
    module Attribute
      def list_attributes(options = {})
        Response::Attribute.format(
          get(attributes_path, options)
        )
      end

      def create_attribute(
        description: nil,
        field_type_id:,
        entity_type_id:,
        key:,
        name:,
        order: Random.rand(100..1000)
      )
        options = {
          'FieldTypeId'  => field_type_id,
          'EntityTypeId' => entity_type_id,
          'Key'          => key,
          'Name'         => name,
          'Description'  => description,
          'Order'        => order,

          # Required fields
          'IsSystem'     => false,
          'IsGridColumn' => false,
          'IsMultiValue' => false,
          'IsRequired'   => false,
          'AllowSearch'  => false
        }

        post(attributes_path, options)
      end

      private

      def attributes_path
        'Attributes'.freeze
      end
    end
  end
end

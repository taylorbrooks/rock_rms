module RockRMS
  class Client
    module DefinedValue
      def list_defined_values(options = {})
        Response::DefinedValue.format(
          get(defined_values_path, options)
        )
      end

      def create_defined_value(defined_type_id:, value:, description:, order: nil, active: false)
        order ||= Random.rand(100..1000)

        options = {
          'Value'         => value,
          'Description'   => description,
          'Order'         => order,
          'IsSystem'      => false,
          'DefinedTypeId' => defined_type_id,
          'IsActive'      => active
        }

        post(defined_values_path, options)
      end

      private

      def defined_values_path
        'DefinedValues'.freeze
      end
    end
  end
end

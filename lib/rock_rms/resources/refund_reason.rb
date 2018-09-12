module RockRMS
  class Client
    module RefundReason
      def list_refund_reasons(options = {})
        options['$filter'] = 'DefinedTypeId eq 37' unless options.keys.include?('$filter')

        Response::DefinedValue.format(
          get(defined_values_path, options)
        )
      end

      def create_refund_reason(value:, description:, order: nil, active: nil)
        order ||= Random.rand(100..1000)

        options = {
          'Value'         => value,
          'Description'   => description,
          'Order'         => order,
          'IsSystem'      => false,
          'DefinedTypeId' => 37
        }
        options['IsActive'] = active if active
        post(defined_values_path, options)
      end

      private

      def defined_values_path
        'DefinedValues'
      end
    end
  end
end

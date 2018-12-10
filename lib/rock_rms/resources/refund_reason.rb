module RockRMS
  class Client
    module RefundReason
      def list_refund_reasons(options = {})
        options['$filter'] = 'DefinedTypeId eq 37' unless options.keys.include?('$filter')
        list_defined_values(options)
      end

      def create_refund_reason(value:, description:, order: nil, active: false)
        create_defined_value(
          value: value,
          description: description,
          order: order,
          active: active,
          defined_type_id: 37
        )
      end
    end
  end
end

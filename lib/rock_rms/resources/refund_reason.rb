module RockRMS
  class Client
    module RefundReason
      def list_refund_reasons(options = {})

        #
        # assumes the DefinedType of "Refund Reason" is 37
        #
        options = {'$filter' => "DefinedTypeId eq 37"}
        Response::DefinedValue.format(get(defined_values_path, options))
      end

      def create_refund_reason(value:, description:, order: nil)

        order ||= Random.rand(1000) + 1000

        options = {
          'Description' => description,
          'Value' => value,
          'Order' => order,
          'IsSystem' => false,
          'DefinedTypeId' => 37,
        }

        #
        # assumes the DefinedType of "Refund Reason" is 37
        #

        post(defined_values_path, options)
      end

      private

      def defined_values_path
        "DefinedValues"        
      end
    end
  end
end

module RockRMS
  class Client
    module SavedPaymentMethod
      def list_saved_payment_methods(options = {})
        res = get(saved_payment_method_path, options)
        Response::SavedPaymentMethod.format(res)
      end

      def create_saved_payment_method(
        gateway_id:,
        payment_detail_id:,
        person_alias_id:,
        name:,
        reference_number:
      )
        options = {
          'FinancialGatewayId'       => gateway_id,
          'FinancialPaymentDetailId' => payment_detail_id,
          'Name'                     => name,
          'PersonAliasId'            => person_alias_id,
          'ReferenceNumber'          => reference_number
        }

        post(saved_payment_method_path, options)
      end

      def delete_saved_payment_method(id)
        delete(saved_payment_method_path(id))
      end

      private

      def saved_payment_method_path(id = nil)
        id ? "FinancialPersonSavedAccounts/#{id}" : 'FinancialPersonSavedAccounts'
      end
    end
  end
end

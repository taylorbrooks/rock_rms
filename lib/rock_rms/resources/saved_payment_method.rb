module RockRMS
  class Client
    module SavedPaymentMethod
      def list_saved_payment_methods(options = {})
        res = get(saved_payment_method_path, options)
        Response::SavedPaymentMethod.format(res)
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

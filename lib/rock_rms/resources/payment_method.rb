module RockRMS
  class Client
    module PaymentMethod

      def list_payment_methods(options={})
        get(payment_method_path, options)
      end

      private

      def payment_method_path(id = nil)
        id ? "FinancialPaymentDetails/#{id}" : "FinancialPaymentDetails"
      end
    end
  end
end

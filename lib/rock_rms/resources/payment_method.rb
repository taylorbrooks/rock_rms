module RockRMS
  class Client
    module PaymentMethod
      def list_payment_methods(options = {})
        res = get(payment_method_path, options)
        Response::PaymentMethod.format(res)
      end

      def create_payment_method(payment_type:, foreign_key: nil)
        options = {
          'CurrencyTypeValueId' => cast_payment_type(payment_type),
          'ForeignKey' => foreign_key
        }

        post(payment_method_path, options)
      end

      private

      def cast_payment_type(payment_type)
        case payment_type
        when 'card'
          156
        when 'bank account', 'ach'
          157
        end
      end

      def payment_method_path(id = nil)
        id ? "FinancialPaymentDetails/#{id}" : 'FinancialPaymentDetails'
      end
    end
  end
end

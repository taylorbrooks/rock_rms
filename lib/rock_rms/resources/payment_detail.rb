module RockRMS
  class Client
    module PaymentDetail
      def list_payment_details(options = {})
        res = get(payment_detail_path, options)
        Response::PaymentDetail.format(res)
      end

      def create_payment_detail(payment_type:, foreign_key: nil, card_type: nil)
        options = {
          'CurrencyTypeValueId' => cast_payment_type(payment_type),
          'CreditCardTypeValueId' => cast_card_type(card_type),
          'ForeignKey' => foreign_key
        }

        post(payment_detail_path, options)
      end

      def delete_payment_detail(id)
        delete(payment_detail_path(id))
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

      def cast_card_type(card_type)
        case card_type
        when 'visa'
          7
        when 'mastercard'
          8
        when 'amex'
          159
        when 'discover'
          160
        when 'diner'
          161
        when 'jcb'
          162
        else
          nil
        end
      end

      def payment_detail_path(id = nil)
        id ? "FinancialPaymentDetails/#{id}" : 'FinancialPaymentDetails'
      end
    end
  end
end

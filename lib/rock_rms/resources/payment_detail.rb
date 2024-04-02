module RockRMS
  class Client
    module PaymentDetail
      def list_payment_details(options = {})
        res = get(payment_detail_path, options)
        Response::PaymentDetail.format(res)
      end

      def create_payment_detail(
        payment_type: nil,
        foreign_key: nil,
        card_type: nil,
        last_4: nil,
        currency_type_value_id: nil
      )
        options = {
          'CurrencyTypeValueId' => currency_type_value_id || cast_payment_type(payment_type),
          'CreditCardTypeValueId' => cast_card_type(card_type),
          'ForeignKey' => foreign_key
        }

        options['AccountNumberMasked'] = "************#{last_4}" if last_4

        post(payment_detail_path, options)
      end

      def update_payment_detail(id, foreign_key: nil, card_type: nil, last_4: nil, currency_type_value_id: nil)
        options = {}

        options['CreditCardTypeValueId'] = cast_card_type(card_type) if card_type
        options['ForeignKey'] = foreign_key if foreign_key
        options['AccountNumberMasked'] = "************#{last_4}" if last_4
        options['CurrencyTypeValueId'] = currency_type_value_id if currency_type_value_id

        patch(payment_detail_path(id), options)
      end

      def delete_payment_detail(id)
        delete(payment_detail_path(id))
      end

      private

      def cast_payment_type(payment_type)
        case payment_type
        when 'cash'
          6
        when 'check'
          9
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
        end
      end

      def payment_detail_path(id = nil)
        id ? "FinancialPaymentDetails/#{id}" : 'FinancialPaymentDetails'
      end
    end
  end
end

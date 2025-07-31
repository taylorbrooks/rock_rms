module RockRMS
  module Response
    class PaymentDetail < Base
      MAP = {
        exp_month: 'ExpirationMonth',
        exp_year: 'ExpirationYear',
        payment_type_id: 'CurrencyTypeValueId',
        masked_number: 'AccountNumberMasked',
        gateway_person_identifier: 'GatewayPersonIdentifier'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

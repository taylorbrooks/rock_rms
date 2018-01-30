module RockRMS
  module Response
    class PaymentMethod < Base
      MAP = {
        id: 'Id',
        foreign_key: 'ForeignKey',
        payment_type_id: 'CurrencyTypeValueId',
        masked_number: 'AccountNumberMasked'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

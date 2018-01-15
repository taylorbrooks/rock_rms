module RockRMS
  class PaymentMethod
    MAP = {
      id: 'Id',
      foreign_key: 'ForeignKey',
      payment_type_id: 'CurrencyTypeValueId',
      masked_number: 'AccountNumberMasked'
    }.freeze

    def self.format(data)
      if data.is_a?(Array)
        data.map { |object| format_single(object) }
      else
        format_single(data)
      end
    end

    def self.format_single(data)
      MAP.each.with_object({}) do |(l, r), object|
        object[l] = data[r]
      end
    end
  end
end

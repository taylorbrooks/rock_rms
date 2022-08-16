module RockRMS
  module Response
    class PhoneNumber < Base
      MAP = {
        person_id: 'PersonId',
        number: 'Number',
        number_type_value_id: 'NumberTypeValueId',
        formatted: 'NumberFormatted',
        formatted_with_cc: 'NumberFormattedWithCountryCode'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

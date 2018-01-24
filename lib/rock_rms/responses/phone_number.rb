module RockRMS
  module Responses
    class PhoneNumber
      MAP = {
        id: 'Id',
        person_id: 'PersonId',
        number: 'Number',
        formatted: 'NumberFormatted',
        formatted_with_cc: 'NumberFormattedWithCountryCode'
      }.freeze

      def self.format(response)
        if response.is_a?(Array)
          response.map { |number| format_number(number) }
        else
          format_number(response)
        end
      end

      def self.format_number(data)
        MAP.each.with_object({}) do |(l, r), object|
          object[l] = data[r]
        end
      end
    end
  end
end

module RockRMS
  class Client
    module PhoneNumber
      def list_phone_numbers(options = {})
        Response::PhoneNumber.format(get(phone_number_path, options))
      end

      private

      def phone_number_path(id = nil)
        id ? "PhoneNumbers/#{id}" : 'PhoneNumbers'
      end
    end
  end
end

module RockRMS
  class Client
    module PhoneNumber
      def list_phone_numbers(options = {})
        Response::PhoneNumber.format(get(phone_number_path, options))
      end

      def create_phone_number(
        number_type_value_id:,
        number:,
        person_id:,
        is_system: true,
        is_messaging_enabled: false
      )
        options = {
          'IsSystem' => is_system,
          'IsMessagingEnabled' => is_messaging_enabled,
          'NumberTypeValueId' => number_type_value_id,
          'Number' => number,
          'PersonId' => person_id
        }

        post(phone_number_path, options)
      end

      private

      def phone_number_path(id = nil)
        id ? "PhoneNumbers/#{id}" : 'PhoneNumbers'
      end
    end
  end
end

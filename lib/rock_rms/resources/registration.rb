module RockRMS
  class Client
    module Registration
      PATH = 'Registrations'.freeze

      def list_registrations(options = {})
        res = get(registration_path, options)
        Response::Registration.format(res)
      end

      def find_registration(id)
        res = get(registration_path(id))
        Response::Registration.format(res)
      end

      def delete_registration(id)
        delete(registration_path(id))
      end

      private

      def registration_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

module RockRMS
  class Client
    module RegistrationSession
      PATH = 'RegistrationSessions'.freeze

      def list_registration_sessions(options = {})
        res = get(registration_session_path, options)
        Response::RegistrationSession.format(res)
      end

      def find_registration_session(id)
        res = get(registration_session_path(id))
        Response::RegistrationSession.format(res)
      end

      private

      def registration_session_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

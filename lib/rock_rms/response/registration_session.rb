module RockRMS
  module Response
    class RegistrationSession < Base
      MAP = {
        registration_instance_id: 'RegistrationInstanceId',
        registration_data: 'RegistrationData',
        session_start_date_time: 'SessionStartDateTime',
        expiration_date_time: 'ExpirationDateTime',
        client_ip_address: 'ClientIpAddress',
        payment_gateway_reference: 'PaymentGatewayReference',
        session_status: 'SessionStatus',
        registration_id: 'RegistrationId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

module RockRMS
  module Response
    class Registration < Base
      MAP = {
        id: 'Id',
        first_name: 'FirstName',
        last_name: 'LastName',
        confirmation_email: 'ConfirmationEmail',
        person_alias_id: 'PersonAliasId',
        registration_instance_id: 'RegistrationInstanceId',
        registration_instance: 'RegistrationInstance',
        registrants: 'Registrants'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:registration_instance] = RegistrationInstance.format(response[:registration_instance])
        response
      end
    end
  end
end

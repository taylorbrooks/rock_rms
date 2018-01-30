module RockRMS
  module Response
    class Person < Base
      MAP = {
        id:         'Id',
        name:       'FullName',
        email:      'Email',
        first_name: 'FirstName',
        last_name:  'LastName',
        giving_id:  'GivingId',
        alias_id:   'PrimaryAliasId',
        connection_status_value_id: 'ConnectionStatusValueId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

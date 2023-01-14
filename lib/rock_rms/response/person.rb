module RockRMS
  module Response
    class Person < Base
      MAP = {
        name:       'FullName',
        email:      'Email',
        first_name: 'FirstName',
        last_name:  'LastName',
        giving_id:  'GivingId',
        giving_group_id: 'GivingGroupId',
        alias_id:   'PrimaryAliasId',
        connection_status_value_id: 'ConnectionStatusValueId',
        record_type_value_id: 'RecordTypeValueId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

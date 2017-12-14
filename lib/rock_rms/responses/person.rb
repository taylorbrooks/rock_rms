module RockRMS
  module Responses
    class Person
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

      def self.format(data)
        if data.is_a?(Array)
          data.map { |object| format_single(object) }
        else
          format_single(data)
        end
      end

      private

      def self.format_single(data)
        MAP.each.with_object({}) do |(l,r), object|
          object[l] = data[r]
        end
      end
    end
  end

  # for backwards compatibility
  Person = Responses::Person
end

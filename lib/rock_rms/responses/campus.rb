module RockRMS
  module Responses
    class Campus
      MAP = {
        id: 'Id',
        name: 'Name',
        is_active: 'IsActive',
        description: 'Description',
        short_code: 'ShortCode',
        url: 'Url',
        location_id: 'LocationId',
        phone_number: 'PhoneNumber',
        service_times: 'ServiceTimes',
        guid: 'Guid'
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
end

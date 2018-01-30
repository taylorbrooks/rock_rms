module RockRMS
  module Response
    class Campus < Base
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

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

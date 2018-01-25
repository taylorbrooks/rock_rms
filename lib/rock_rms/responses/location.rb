module RockRMS
  module Responses
    class Location
      MAP = {
        id: 'Id',
        name: 'Name',
        is_active: 'IsActive',
        street1: 'Street1',
        street2: 'Street2',
        city: 'City',
        county: 'County',
        state: 'State',
        country: 'Country',
        postal_code: 'PostalCode',
        latitude: 'Latitude',
        longitude: 'Longitude',
        guid: 'Guid'
      }.freeze

      def self.format(data)
        if data.is_a?(Array)
          data.map { |object| format_single(object) }
        else
          format_single(data)
        end
      end

      def self.format_single(data)
        MAP.each.with_object({}) do |(l, r), object|
          object[l] = data[r]
        end
      end
    end
  end
end

module RockRMS
  module Response
    class Location < Base
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

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

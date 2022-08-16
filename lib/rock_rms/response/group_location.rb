module RockRMS
  module Response
    class GroupLocation < Base
      MAP = {
        group_id: 'GroupId',
        location_id: 'LocationId',
        guid: 'Guid'
      }.freeze

      def format_single(data)
        result = to_h(MAP, data)

        if location = data['Location']
          result[:location] = Location.format(location)
        end

        result
      end
    end
  end
end

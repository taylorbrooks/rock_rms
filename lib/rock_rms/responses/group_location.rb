module RockRMS
  module Responses
    class GroupLocation
      MAP = {
        id: 'Id',
        group_id: 'GroupId',
        location_id: 'LocationId',
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
        result = MAP.each.with_object({}) do |(l,r), object|
          object[l] = data[r]
        end

        if location = data['Location']
          result[:location] = Location.format(location)
        end

        result
      end
    end
  end
end

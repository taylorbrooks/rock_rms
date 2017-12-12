module RockRMS
  module Responses
    class Group
      MAP = {
        id: "Id",
        name: "Name",
        group_type_id: "GroupTypeId",
        parent_group_id: "ParentGroupId",
        campus_id: "CampusId",
        is_active: "IsActive",
        guid: "Guid",
        members: "Members"
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

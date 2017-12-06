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

      FORMAT = -> (data) {
        MAP.each.with_object({}) do |(l,r), object|
          object[l] = data[r]
        end
      }

      def self.format(data)
        if data.is_a?(Array)
          data.map { |object| FORMAT.call(object) }
        else
          FORMAT.call(data)
        end
      end
    end
  end
end

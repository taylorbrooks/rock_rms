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
        guid: "Guid"
      }.freeze

      def self.format(data)
        MAP.each.with_object({}) do |(l,r), object|
          object[l] = data[r]
        end
      end
    end
  end
end

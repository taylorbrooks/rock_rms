module RockRMS
  module Response
    class Group < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        group_type_id: 'GroupTypeId',
        parent_group_id: 'ParentGroupId',
        campus_id: 'CampusId',
        is_active: 'IsActive',
        guid: 'Guid',
        members: 'Members'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        result = to_h(MAP, data)

        if group_locations = data['GroupLocations']
          result[:group_locations] = GroupLocation.format(group_locations)
        end

        if campus = data['Campus']
          result[:campus] = Campus.format(campus)
        end

        result
      end
    end
  end
end

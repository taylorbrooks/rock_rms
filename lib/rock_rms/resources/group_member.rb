module RockRMS
  class Client
    module GroupMember

      def create_group_member(group_id:,
                              group_member_status:,
                              group_role_id:,
                              person_id:)
        post(
          group_member_path,
          {
            IsSystem: false,
            GroupId: group_id,
            GroupMemberStatus: group_member_status,
            GroupRoleId: group_role_id,
            PersonId: person_id
          }
        )
      end

      private

      def group_member_path(id = nil)
        id ? "GroupMembers/#{id}" : 'GroupMembers'
      end
    end
  end
end


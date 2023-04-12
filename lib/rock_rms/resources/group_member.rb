module RockRMS
  class Client
    module GroupMember
      def create_group_member(group_id:,
                              group_member_status:,
                              group_role_id:,
                              person_id:)
        post(
          group_member_path,
          IsSystem: false,
          GroupId: group_id,
          GroupMemberStatus: group_member_status,
          GroupRoleId: group_role_id,
          PersonId: person_id
        )
      end

      def list_group_members(options = {})
        Response::GroupMember.format(
          get(group_member_path, options)
        )
      end

      def delete_group_member(id)
        delete(group_member_path(id))
      end

      private

      def group_member_path(id = nil)
        id ? "GroupMembers/#{id}" : 'GroupMembers'
      end
    end
  end
end

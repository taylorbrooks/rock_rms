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

      def delete_group_member(id)
        delete(group_member_path(id))
      end

      def create_known_relationship(person_id:, related_person_id:, relationship_role_id:)
        url_params = {
          personId: person_id,
          relatedPersonId: related_person_id,
          relationshipRoleId: relationship_role_id
        }

        post("GroupMembers/KnownRelationship?#{URI.encode_www_form(url_params)}")
      end

      private

      def group_member_path(id = nil)
        id ? "GroupMembers/#{id}" : 'GroupMembers'
      end
    end
  end
end

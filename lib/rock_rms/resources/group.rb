module RockRMS
  class Client
    module Group
      def list_groups(options = {})
        RockRMS::Responses::Group.format(get(group_path, options))
      end

      def list_groups_for_person(person_id, options = {})
        options['$filter'] = Array(options['$filter'])
          .push("Members/any(m: m/PersonId eq #{person_id})")
          .join(' and ')
        options['$expand'] = 'Members'

        list_groups(options)
      end

      private

      def group_path(id = nil)
        id ? "Groups/#{id}" : "Groups"
      end
    end
  end
end

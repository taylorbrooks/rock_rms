module RockRMS
  class Client
    module Group
      def list_groups(options = {})
        RockRMS::Responses::Group.format(get(group_path, options))
      end

      def list_groups_for_person(person_id, options = {})
        opts = options.dup
        opts['$filter'] = Array(opts['$filter'])
          .push("Members/any(m: m/PersonId eq #{person_id})")
          .join(' and ')
        opts['$expand'] ||= 'Members'

        list_groups(opts)
      end

      def list_families_for_person(person_id, options = {})
        RockRMS::Responses::Group.format(
          get("Groups/GetFamilies/#{person_id}", options)
        )
      end

      private

      def group_path(id = nil)
        id ? "Groups/#{id}" : "Groups"
      end
    end
  end
end

module RockRMS
  class Client
    module Person
      def list_people(options = {})
        res = get(people_path, options)
        RockRMS::Responses::Person.format(res)
      end

      def find_person(id)
        res = get(people_path(id))
        RockRMS::Responses::Person.format(res)
      end

      def find_person_by_email(email)
        res = get("People/GetByEmail/#{email}")
        RockRMS::Responses::Person.format(res)
      end

      NAME_SEARCH_DEFAULTS = {
        includeHtml: false,
        includeDetails: true,
        includeBusinesses: false,
        includeDeceased: false
      }.freeze

      def find_person_by_name(full_name, options = {})
        priority = options.merge(name: full_name)

        RockRMS::Responses::Person.format(
          get('People/Search', NAME_SEARCH_DEFAULTS.merge(priority))
        )
      end

      def create_person(first_name:, last_name:, email:)
        options = {
          'IsSystem' => false,
          'FirstName' => first_name,
          'LastName' => last_name,
          'Email' => email,
          'Gender' => 1
        }
        post(people_path, options)
      end

      def update_person(id, options = {})
        put(people_path(id), options)
      end

      private

      def people_path(id = nil)
        id ? "People/#{id}" : 'People'
      end
    end
  end
end

module RockRMS
  class Client
    module Person
      def list_people(options = {})
        res = get(people_path, options)
        Response::Person.format(res)
      end

      def find_person(id)
        res = get(people_path(id))
        Response::Person.format(res)
      end

      def find_person_by_alias_id(id)
        Response::Person.format(get("People/GetByPersonAliasId/#{id}"))
      end

      def find_person_by_email(email)
        res = get("People/GetByEmail/#{email}")
        Response::Person.format(res)
      end

      NAME_SEARCH_DEFAULTS = {
        includeHtml: false,
        includeDetails: true,
        includeBusinesses: false,
        includeDeceased: false
      }.freeze

      def find_person_by_name(full_name, options = {})
        priority = options.merge(name: full_name)

        Response::Person.format(
          get('People/Search', NAME_SEARCH_DEFAULTS.merge(priority))
        )
      end

      def create_person(
        first_name:,
        last_name:,
        email:,
        gender: 1,
        connection_status_value_id: nil,
        record_status_value_id: nil,
        record_type_value_id: 1,
        email_preference: 0
      )
        options = {
          'IsSystem' => false,
          'FirstName' => first_name,
          'LastName' => last_name,
          'Email' => email,
          'EmailPreference' => email_preference,
          'Gender' => gender,
          'ConnectionStatusValueId' => connection_status_value_id,
          'RecordStatusValueId' => record_status_value_id,
          'RecordTypeValueId' => record_type_value_id
        }

        # RecordTypeValueId 1 = Person
        # RecordTypeValueId 2 = Business

        post(people_path, options)
      end

      def create_business(name:, email:, connection_status_value_id: nil, record_status_value_id: nil, record_type_value_id: 2)
        options = {
          'IsSystem' => false,
          'LastName' => name,
          'Email' => email,
          'Gender' => 1,
          'ConnectionStatusValueId' => connection_status_value_id,
          'RecordStatusValueId'     => record_status_value_id,
          'RecordTypeValueId'     => record_type_value_id,
        }

        # RecordTypeValueId 2 = Business

        post(people_path, options)
      end

      def update_person(id, options = {})
        put(people_path(id), options)
      end

      def launch_person_workflow(
        id,
        workflow_type_id:,
        workflow_name:,
        attributes: {}
      )
        query_string = "?workflowTypeId=#{workflow_type_id}&workflowName=#{workflow_name}"
        post(people_path + "/LaunchWorkflow/#{id}#{query_string}", attributes)
      end

      private

      def people_path(id = nil)
        id ? "People/#{id}" : 'People'
      end
    end
  end
end

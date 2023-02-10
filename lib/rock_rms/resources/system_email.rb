module RockRMS
  class Client
    module SystemEmail
      def list_system_emails(options = {})
        res = get('SystemEmails', options)
        Response::SystemEmail.format(res)
      end

      def update_system_email(id, body:)
        options = {
          'Body' => body
        }

        patch("SystemEmails/#{id}", options)
      end
    end
  end
end

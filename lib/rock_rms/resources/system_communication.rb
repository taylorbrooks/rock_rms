module RockRMS
  class Client
    module SystemCommunication
      def list_system_communications(options = {})
        res = get('SystemCommunications', options)
        Response::SystemCommunication.format(res)
      end

      def update_system_communcation(id, body:)
        options = {
          'Body' => body
        }

        patch("SystemCommunications/#{id}", options)
      end
    end
  end
end

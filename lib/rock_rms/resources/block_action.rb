module RockRMS
  class Client
    module BlockAction
      def create_block_action(page_guid:, block_guid:, action_name:, body:)
        post(block_action_path(page_guid, block_guid, action_name), body)
      end

      private

      def block_action_path(page_guid, block_guid, action_name)
        "v2/BlockActions/#{page_guid}/#{block_guid}/#{action_name}"
      end
    end
  end
end

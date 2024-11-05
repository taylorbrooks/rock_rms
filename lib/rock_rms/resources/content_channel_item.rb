module RockRMS
  class Client
    module ContentChannelItem
      def list_content_channel_items(options = {})
        res = get(content_channel_items_path, options)
        Response::ContentChannelItem.format(res)
      end
    end
  end
end

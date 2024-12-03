module RockRMS
  class Client
    module ContentChannelItem
      def list_content_channel_items(options = {})
        res = get('ContentChannelItems', options)
        Response::ContentChannelItem.format(res)
      end
    end
  end
end

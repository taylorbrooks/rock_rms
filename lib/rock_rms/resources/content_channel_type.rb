module RockRMS
  class Client
    module ContentChannelType
      def list_content_channel_types(options = {})
        res = get('ContentChannelTypes', options)
        Response::ContentChannelType.format(res)
      end
    end
  end
end


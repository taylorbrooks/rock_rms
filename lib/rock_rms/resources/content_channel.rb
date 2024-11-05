module RockRMS
  class Client
    module ContentChannel
      def list_content_channels(options = {})
        res = get(content_channel_path, options)
        Response::ContentChannel.format(res)
      end

      def find_content_channel(id)
        res = get(content_channel_path(id))
        Response::ContentChannel.format(res)
      end

      def update_content_channel(
        id:,
        foreign_key: nil
      )
        options = { foreign_key: foreign_key }.compact

        patch(content_channel_path(id), options)
      end

      private

      def content_channel_path(id = nil)
        id ? "ContentChannels/#{id}" : 'ContentChannels'
      end
    end
  end
end


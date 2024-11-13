module RockRMS
  module Response
    class ContentChannelItem < Base
      MAP = {
        content_channel_id: 'ContentChannelId',
        title: 'Title',
        content: 'Content',
        order: 'Order',
        start_date: 'StartDateTime',
        expire_date: 'ExpireDateTime',
      }

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

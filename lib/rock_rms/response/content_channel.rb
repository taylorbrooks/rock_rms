module RockRMS
  module Response
    class ContentChannel < Base
      MAP = {
        name: 'Name',
        description: 'Description',
        is_active: 'IsActive',
        icon_css_class: 'IconCssClass',
        content_channel_type_id: 'ContentChannelTypeId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

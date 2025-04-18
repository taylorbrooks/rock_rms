module RockRMS
  module Response
    class ContentChannelType < Base
      MAP = {
        name: 'Name'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

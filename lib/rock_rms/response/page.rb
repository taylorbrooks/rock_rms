module RockRMS
  module Response
    class Page < Base
      MAP = {
        id: 'Id',
        name: 'InternalName',
        page_title: 'PageTitle',
        browser_title: 'BrowserTitle',
        blocks: 'Blocks'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:blocks] = Block.format(response[:blocks])
        response
      end
    end
  end
end

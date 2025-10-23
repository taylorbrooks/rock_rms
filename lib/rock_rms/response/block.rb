module RockRMS
  module Response
    class Block < Base
      MAP = {
        name: 'Name',
        block_type: 'BlockType',
        order: 'Order',
        page_id: 'PageId',
        zone: 'Zone'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:block_type] = BlockType.format(response[:block_type])
        response
      end
    end
  end
end

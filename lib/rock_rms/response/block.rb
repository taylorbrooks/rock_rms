module RockRMS
  module Response
    class Block < Base
      MAP = {
        name: 'Name',
        block_type: 'BlockType',
        page_id: 'PageId'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:block_type] = BlockType.format(response[:block_type])
        response
      end
    end
  end
end

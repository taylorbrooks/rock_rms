module RockRMS
  module Response
    class Block < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        block_type: 'BlockType'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:block_type] = BlockType.format(response[:block_type])
        response
      end
    end
  end
end

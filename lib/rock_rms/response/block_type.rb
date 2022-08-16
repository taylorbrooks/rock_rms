module RockRMS
  module Response
    class BlockType < Base
      MAP = {
        name: 'Name',
        description: 'Description',
        category: 'Category',
        path: 'Path'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

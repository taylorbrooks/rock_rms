module RockRMS
  module Response
    class BlockType < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        description: 'Description',
        category: 'Category',
        path: 'Path'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

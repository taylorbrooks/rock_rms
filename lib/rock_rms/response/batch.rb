module RockRMS
  module Response
    class Batch < Base
      MAP = {
        id: 'Id'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

module RockRMS
  module Response
    class Gateway < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        active: 'IsActive'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

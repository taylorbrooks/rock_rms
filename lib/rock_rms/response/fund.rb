module RockRMS
  module Response
    class Fund < Base
      MAP = {
        id:   'Id',
        campus_id: 'CampusId',
        name: 'Name'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

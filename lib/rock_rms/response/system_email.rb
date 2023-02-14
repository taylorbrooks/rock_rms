module RockRMS
  module Response
    class SystemEmail < Base
      MAP = {
        title: 'Title',
        from: 'From',
        subject: 'Subject',
        body: 'Body',
        foreign_key: 'ForeignKey'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

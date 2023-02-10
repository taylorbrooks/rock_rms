module RockRMS
  module Response
    class SystemCommunication < Base
      MAP = {
        title: 'Title',
        from: 'From',
        subject: 'Subject',
        body: 'Body'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

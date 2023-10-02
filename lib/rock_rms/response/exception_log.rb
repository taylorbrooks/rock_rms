module RockRMS
  module Response
    class ExceptionLog < Base
      MAP = {
        exception_type: 'ExceptionType',
        description: 'Description',
        stack_trace: 'StackTrace',
        page_url: 'PageUrl',
        source: 'Source',
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

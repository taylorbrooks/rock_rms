module RockRMS
  class Client
    module ExceptionLog
      def list_exception_logs(options = {})
        Response::ExceptionLog.format(
          get(exception_logs_path, options)
        )
      end

      private

      def exception_logs_path
        'ExceptionLogs'.freeze
      end
    end
  end
end

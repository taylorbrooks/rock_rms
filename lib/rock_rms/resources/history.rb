module RockRMS
  class Client
    module History
      def list_history(options = {})
        res = get('Histories', options)
        Response::History.format(res)
      end
    end
  end
end

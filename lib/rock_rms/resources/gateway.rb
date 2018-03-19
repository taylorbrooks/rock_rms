module RockRMS
  class Client
    module Gateway
      def list_gateways(options = {})
        Response::Gateway.format(
          get('FinancialGateways', options)
        )
      end
    end
  end
end

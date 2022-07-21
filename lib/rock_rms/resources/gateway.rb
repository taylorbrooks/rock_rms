module RockRMS
  class Client
    module Gateway
      PATH = 'FinancialGateways'.freeze

      def list_gateways(options = {})
        res = get(gateway_path, options)
        Response::Gateway.format(res)
      end

      def delete_gateway(id)
        delete(gateway_path(id))
      end

      private

      def gateway_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

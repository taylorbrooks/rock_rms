module RockRMS
  class Client
    module Fund
      def list_funds(options = {})
        res = get(fund_path, options)
        Response::Fund.format(res)
      end

      def find_fund(id)
        res = get(fund_path(id))
        Response::Fund.format(res)
      end

      private

      def fund_path(id = nil)
        id ? "FinancialAccounts/#{id}" : 'FinancialAccounts'
      end
    end
  end
end

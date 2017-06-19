module RockRMS
  class Client
    module Fund

      def list_funds(options={})
        res = get(fund_path, options)
        RockRMS::Fund.format(res)
      end

      private

      def fund_path(id = nil)
        id ? "FinancialAccounts/#{id}" : "FinancialAccounts"
      end

    end
  end
end

module RockRMS
  class Client
    module TransactionDetail

      def list_transaction_details(options={})
        get(transaction_detail_path, options)
      end

      def find_transaction_detail(id)
        get(transaction_detail_path(id))
      end

      def update_transaction_detail(id, account_id:)
        options = {
          "AccountId" => account_id
        }
        patch(transaction_detail_path(id), options)
      end

      private

      def transaction_detail_path(id = nil)
        id ? "FinancialTransactionDetails/#{id}" : "FinancialTransactionDetails"
      end
    end
  end
end

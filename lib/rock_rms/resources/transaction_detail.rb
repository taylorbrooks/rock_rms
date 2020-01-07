module RockRMS
  class Client
    module TransactionDetail
      def list_transaction_details(options = {})
        res = get(transaction_detail_path, options)
        Response::TransactionDetail.format(res)
      end

      def find_transaction_detail(id)
        res = get(transaction_detail_path(id))
        Response::TransactionDetail.format(res)
      end

      def update_transaction_detail(id, fund_id: nil, fee_amount: nil)
        options = {}
        options['AccountId'] = fund_id    if fund_id
        options['FeeAmount'] = fee_amount if fee_amount

        patch(transaction_detail_path(id), options)
      end

      private

      def transaction_detail_path(id = nil)
        id ? "FinancialTransactionDetails/#{id}" : 'FinancialTransactionDetails'
      end
    end
  end
end

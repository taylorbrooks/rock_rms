module RockRMS
  class Client
    module TransactionImage
      def create_transaction_image(
        binary_file_id:,
        transaction_id:
      )
        options = {
          'BinaryFileId' => binary_file_id,
          'Transactionid' => transaction_id
        }

        post(transaction_image_path, options)
      end

      private

      def transaction_image_path(id = nil)
        id ? "FinancialTransactionImages/#{id}" : 'FinancialTransactionImages'
      end
    end
  end
end

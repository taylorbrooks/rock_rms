module RockRMS
  class Client
    module Refund
      PATH = 'FinancialTransactionRefunds'.freeze

      def create_refund(
        batch_id:,
        date:,
        reason_id:,
        transaction_id:,
        transaction_code: nil
      )
        old_transaction = list_transactions(
          '$expand' => 'TransactionDetails',
          '$filter' => "Id eq #{transaction_id}"
        ).first

        params = {
          'OriginalTransactionId' => transaction_id,
          'RefundReasonValueId' => reason_id,
          'FinancialTransaction' => {
            'AuthorizedPersonAliasId' => old_transaction[:person_id],
            'BatchId' => batch_id,
            'FinancialPaymentDetailId' => old_transaction[:payment_detail_id],
            'TransactionCode'     => transaction_code,
            'TransactionDateTime' => date,
            'TransactionDetails'  => translate_negative(old_transaction[:details]),
            'TransactionTypeValueId' => old_transaction[:transaction_type_id]
          }
        }
        post(refund_path, params)
      end

      private

      def translate_negative(details)
        details.map do |dt|
          {
            'Amount' => -dt[:amount],
            'AccountId' => dt[:fund_id]
          }
        end
      end

      def refund_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

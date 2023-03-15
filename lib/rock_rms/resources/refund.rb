module RockRMS
  class Client
    module Refund
      PATH = 'FinancialTransactionRefunds'.freeze

      def create_refund(
        batch_id:,
        date:,
        reason_id:,
        transaction_id:,
        transaction_code: nil,
        amount: nil,
        gateway_id: nil
      )

        old_transaction = list_transactions(
          '$expand' => 'TransactionDetails',
          '$filter' => "Id eq #{transaction_id}"
        ).first

        transaction_amount = old_transaction[:details].map{|d| d[:amount]}.reduce(0.0){|sum,x| sum + x }

        refund_amount = amount || transaction_amount

        params = {
          'OriginalTransactionId' => transaction_id,
          'RefundReasonValueId' => reason_id,
          'FinancialTransaction' => {
            'AuthorizedPersonAliasId' => old_transaction[:person_id],
            'BatchId' => batch_id,
            'FinancialGatewayId' => gateway_id,
            'FinancialPaymentDetailId' => old_transaction[:payment_detail_id],
            'TransactionCode'     => transaction_code,
            'TransactionDateTime' => date,
            'TransactionDetails'  => refunded_details(old_transaction[:details], transaction_amount, refund_amount),
            'TransactionTypeValueId' => old_transaction[:transaction_type_id],
            'SourceTypeValueId' => old_transaction[:source_type_id]
          }
        }
        post(refund_path, params)
      end

      private

      def refunded_details(details, transaction_amount, refund_amount)
        apportion_refund_amount_over_accounts(details, transaction_amount, refund_amount).map do |dt|
          {
            'Amount' => -dt[:amount],
            'AccountId' => dt[:fund_id],
            'EntityTypeId' => dt[:entity_type_id],
            'EntityId' => dt[:entity_id]
          }
        end
      end

      def apportion_refund_amount_over_accounts(details, transaction_amount, refund_amount)
        if refund_amount >= transaction_amount
          details
        else
          ratio = refund_amount / transaction_amount
          initial_acc = {total_amount: transaction_amount, details: []}
          result = details.reduce(initial_acc) do |acc, detail|
            amount_for_this_detail = (detail[:amount] * ratio).round(2)
            new_total_amount = acc[:total_amount] - amount_for_this_detail
            detail[:amount] = amount_for_this_detail
            new_details = acc[:details] << detail
            {
              total_amount: new_total_amount,
              details: new_details,
            }
          end

          result[:details]
        end
      end

      def refund_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

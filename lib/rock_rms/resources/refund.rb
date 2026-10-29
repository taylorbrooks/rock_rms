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
            'TransactionDetails'  => refunded_details(old_transaction[:details], refund_amount),
            'TransactionTypeValueId' => old_transaction[:transaction_type_id],
            'SourceTypeValueId' => old_transaction[:source_type_id],
            'ScheduledTransactionId' => old_transaction[:recurring_donation_id]
          }
        }
        post(refund_path, params)
      end

      private

      def refunded_details(details, refund_amount)
        apportion_refund_amount_over_accounts(details, refund_amount).map do |dt|
          {
            'Amount' => -dt[:amount],
            'AccountId' => dt[:fund_id],
            'EntityTypeId' => dt[:entity_type_id],
            'EntityId' => dt[:entity_id]
          }
        end
      end

      def apportion_refund_amount_over_accounts(details, refund_amount)
        detail_cents = details.map { |detail| (detail[:amount] * 100).round }
        total_cents = detail_cents.sum
        refund_cents = (refund_amount * 100).round
        return details if refund_cents >= total_cents

        shares, remainders = detail_cents.map { |cents| (cents * refund_cents).divmod(total_cents) }.transpose
        leftover = refund_cents - shares.sum
        details.each_index.sort_by { |i| [-remainders[i], i] }.first(leftover).each { |i| shares[i] += 1 }

        details.zip(shares).map { |detail, cents| detail.merge(amount: cents / 100.0) }
      end

      def refund_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

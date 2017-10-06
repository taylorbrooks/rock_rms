module RockRMS
  class Client
    module Donation

      def list_donations(options={})
        res = get(transaction_path, options)
        RockRMS::Donation.format(res)
      end

      def find_donations_by_giving_id(id, raw = false)
        res = get("FinancialTransactions/GetByGivingId/#{id}?$expand=TransactionDetails")
        raw ? res : RockRMS::Donation.format(res)
      end

      def find_donation(id)
        res = get(transaction_path(id))
        RockRMS::Donation.format(res)
      end

      def create_donation(payment_type:, authorized_person_id:, amount:, date:, fund_id:, batch_id:, transaction_code: nil)
        options = {
          "AuthorizedPersonAliasId" => authorized_person_id,
          "BatchId" => batch_id,
          "FinancialPaymentDetailId" => payment_type,
          "TransactionCode" => transaction_code,
          "TransactionDateTime" => date,
          "TransactionDetails"  => [{
            "Amount"    => amount,
            "AccountId" => fund_id,
          }],
          "TransactionTypeValueId" => 53, # contribution, registration
          "SourceTypeValueId" => 10,      # website, kiosk, mobile app
        }
        post(transaction_path, options)
      end

      def update_donation(id, batch_id:)
        options = {
          "BatchId" => batch_id
        }
        patch(transaction_path(id), options)
      end

      def delete_donation(id)
        delete(transaction_path(id))
      end

      private

      def transaction_path(id = nil)
        id ? "FinancialTransactions/#{id}" : "FinancialTransactions"
      end

    end
  end
end

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

      def find_donations(id)
        res = get(transaction_path(id))
        RockRMS::Donation.format(res)
      end

      def create_donation(authorized_person_id:, amount:, date:, fund_id:)
        options = {
          "TransactionDateTime" => date,
          "AuthorizedPersonAliasId" => authorized_person_id,
          "TransactionDetails"  => [{
            "Amount"    => amount,
            "AccountId" => fund_id
          }],
          "TransactionTypeValueId" => 53, # transaction type "contribution", "registration"
          "FinancialPaymentDetailId" => 1
        }
        post(transaction_path, options)
      end

      def update_transaction(id, options={})
        put(transaction_path(id), options)
      end

      def delete_transaction(id)
        delete(transaction_path(id))
      end

      private

      def transaction_path(id = nil)
        id ? "FinancialTransactions/#{id}" : "FinancialTransactions"
      end

    end
  end
end

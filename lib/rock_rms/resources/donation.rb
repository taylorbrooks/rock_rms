module RockRMS
  class Client
    module Donation
      def list_donations(options = {})
        res = get(transaction_path, options)
        RockRMS::Responses::Donation.format(res)
      end

      def find_donations_by_giving_id(id, raw = false)
        res = get("FinancialTransactions/GetByGivingId/#{id}?$expand=TransactionDetails")
        raw ? res : RockRMS::Responses::Donation.format(res)
      end

      def find_donation(id)
        res = get(transaction_path(id))
        RockRMS::Responses::Donation.format(res)
      end

      def create_donation(
        authorized_person_id:,
        batch_id:,
        date:,
        funds:,
        payment_type:,
        source_type_id: 10,
        transaction_code: nil,
        summary: nil,
        recurring_donation_id: nil
      )

        options = {
          'AuthorizedPersonAliasId' => authorized_person_id,
          'ScheduledTransactionId' => recurring_donation_id,
          'BatchId' => batch_id,
          'FinancialPaymentDetailId' => payment_type,
          'TransactionCode' => transaction_code,
          'TransactionDateTime' => date,
          'TransactionDetails'  => translate_funds(funds),
          'TransactionTypeValueId' => 53,        # contribution, registration
          'SourceTypeValueId' => source_type_id, # website, kiosk, mobile app
          'Summary' => summary,
        }
        post(transaction_path, options)
      end

      def update_donation(id, batch_id: nil, summary: nil, recurring_donation_id: nil)
        options = {}
        if summary
          options = options.merge({'Summary' => summary})
        end
        if recurring_donation_id
          options = options.merge({'ScheduledTransactionId' => recurring_donation_id})
        end
        if batch_id
          options = options.merge({'BatchId' => batch_id})
        end
        patch(transaction_path(id), options)
      end

      def delete_donation(id)
        delete(transaction_path(id))
      end

      private

      def translate_funds(funds)
        funds.map do |fund|
          {
            'Amount' => fund[:amount],
            'AccountId' => fund[:fund_id]
          }
        end
      end

      def transaction_path(id = nil)
        id ? "FinancialTransactions/#{id}" : 'FinancialTransactions'
      end
    end
  end
end

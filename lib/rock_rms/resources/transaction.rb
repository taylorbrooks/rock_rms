module RockRMS
  class Client
    module Transaction
      PATH = 'FinancialTransactions'.freeze

      def list_transactions(options = {})
        res = get(transaction_path, options)
        Response::Transaction.format(res)
      end

      def find_donations_by_giving_id(id, raw = false)
        res = get("#{PATH}/GetByGivingId/#{id}?$expand=TransactionDetails")
        raw ? res : Response::Transaction.format(res)
      end

      def find_transaction(id)
        res = get(transaction_path(id))
        Response::Transaction.format(res)
      end

      def create_transaction(
        authorized_person_id:,
        batch_id:,
        date:,
        funds:,
        payment_type:,
        source_type_id: 10,
        transaction_code: nil,
        summary: nil,
        recurring_donation_id: nil,
        gateway_id: nil
      )

        options = {
          'AuthorizedPersonAliasId' => authorized_person_id,
          'ScheduledTransactionId' => recurring_donation_id,
          'BatchId' => batch_id,
          'FinancialGatewayId' => gateway_id,
          'FinancialPaymentDetailId' => payment_type,
          'TransactionCode' => transaction_code,
          'TransactionDateTime' => date,
          'TransactionDetails'  => translate_funds(funds),
          'TransactionTypeValueId' => 53,        # contribution, registration
          'SourceTypeValueId' => source_type_id, # website, kiosk, mobile app
          'Summary' => summary
        }
        post(transaction_path, options)
      end

      def update_transaction(
        id,
        batch_id: nil,
        summary: nil,
        recurring_donation_id: nil,
        gateway_id: nil
      )
        options = {}

        options['Summary'] = summary  if summary
        options['BatchId'] = batch_id if batch_id
        options['FinancialGatewayId']     = gateway_id            if gateway_id
        options['ScheduledTransactionId'] = recurring_donation_id if recurring_donation_id

        patch(transaction_path(id), options)
      end

      def delete_transaction(id)
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
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

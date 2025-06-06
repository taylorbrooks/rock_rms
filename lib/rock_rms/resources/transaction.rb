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
        payment_detail_id:,
        source_type_id: 10,
        transaction_code: nil,
        summary: nil,
        recurring_donation_id: nil,
        gateway_id: nil,
        transaction_type_value_id: 53,        # contribution, registration
        show_as_anonymous: nil
      )

        options = {
          'AuthorizedPersonAliasId' => authorized_person_id,
          'ScheduledTransactionId' => recurring_donation_id,
          'BatchId' => batch_id,
          'FinancialGatewayId' => gateway_id,
          'FinancialPaymentDetailId' => payment_detail_id,
          'TransactionCode' => transaction_code,
          'TransactionDateTime' => date,
          'TransactionDetails'  => translate_funds(funds),
          'TransactionTypeValueId' => transaction_type_value_id,
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
        gateway_id: nil,
        source_type_id: nil,
        transaction_code: nil,
        transaction_type_value_id: nil,
        authorized_person_id: nil,
        date: nil,
        foreign_currency_code_value_id: nil,
        show_as_anonymous: nil
      )
        options = {}

        options['Summary'] = summary  if summary
        options['BatchId'] = batch_id if batch_id
        options['FinancialGatewayId']      = gateway_id                if gateway_id
        options['ScheduledTransactionId']  = recurring_donation_id     if recurring_donation_id
        options['SourceTypeValueId']       = source_type_id            if source_type_id
        options['TransactionTypeValueId']  = transaction_type_value_id if transaction_type_value_id
        options['TransactionCode']         = transaction_code          if transaction_code
        options['AuthorizedPersonAliasId'] = authorized_person_id      if authorized_person_id
        options['TransactionDateTime']     = date                      if date
        options['ForeignCurrencyCodeValueId'] = foreign_currency_code_value_id if foreign_currency_code_value_id
        options['ShowAsAnonymous'] = show_as_anonymous if show_as_anonymous

        patch(transaction_path(id), options)
      end

      def delete_transaction(id)
        delete(transaction_path(id))
      end

      def refund_transaction(id)
        post(transaction_path + "/Refund/#{id}")
      end

      def launch_transaction_workflow(
        id,
        workflow_type_id:,
        workflow_name:,
        attributes: {}
      )
        query_string = "?workflowTypeId=#{workflow_type_id}&workflowName=#{workflow_name}"
        post(transaction_path + "/LaunchWorkflow/#{id}#{query_string}", attributes)
      end

      private

      def translate_funds(funds)
        funds.map do |fund|
          {
            'Amount' => fund[:amount],
            'AccountId' => fund[:fund_id],
            'EntityTypeId' => fund[:entity_type_id],
            'EntityId' => fund[:entity_id],
            'FeeAmount' => fund[:fee_amount],
            'FeeCoverageAmount' => fund[:fee_coverage_amount]
          }
        end
      end

      def transaction_path(id = nil)
        id ? "#{PATH}/#{id}" : PATH
      end
    end
  end
end

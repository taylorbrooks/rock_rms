module RockRMS
  class Client
    module RecurringDonation
      def list_recurring_donations(options = {})
        res = get(recurring_donation_path, options)
        Response::RecurringDonation.format(res)
      end

      def find_recurring_donation(id)
        res = get(recurring_donation_path(id))
        Response::RecurringDonation.format(res)
      end

      def create_recurring_donation(
        active: true,
        authorized_person_id:,
        foreign_key: nil,
        frequency:,
        funds:,
        gateway_id: nil,
        gateway_schedule_id: nil,
        next_payment_date:,
        payment_detail_id: nil,
        source_type_id: 10,
        transaction_code: nil,
        start_date:
      )

        options = {
          'AuthorizedPersonAliasId'     => authorized_person_id,
          'TransactionFrequencyValueId' => RecurringFrequencies::RECURRING_FREQUENCIES[frequency],
          'StartDate'                   => start_date,
          'NextPaymentDate'             => next_payment_date,
          'IsActive'                    => active,
          'FinancialGatewayId'          => gateway_id,
          'FinancialPaymentDetailId'    => payment_detail_id,
          'TransactionCode'             => transaction_code,
          'ScheduledTransactionDetails' => translate_funds(funds),
          'GatewayScheduleId'           => gateway_schedule_id,
          'SourceTypeValueId'           => source_type_id,
          'ForeignKey'                  => foreign_key
        }
        post(recurring_donation_path, options)
      end

      def update_recurring_donation(
        id,
        next_payment_date:,
        transaction_code: nil,
        payment_detail_id: nil,
        active: nil
      )
        options = { 'NextPaymentDate' => next_payment_date }
        options['FinancialPaymentDetailId'] = payment_detail_id if payment_detail_id
        options['TransactionCode']          = transaction_code  if transaction_code
        options['IsActive']                 = active            if !active.nil?

        patch(recurring_donation_path(id), options)
      end

      def delete_recurring_donation(id)
        delete(recurring_donation_path(id))
      end

      def launch_scheduled_transaction_workflow(
        id,
        workflow_type_id:,
        workflow_name:,
        attributes: {}
      )
        query_string = "?workflowTypeId=#{workflow_type_id}&workflowName=#{workflow_name}"
        post(recurring_donation_path + "/LaunchWorkflow/#{id}#{query_string}", attributes)
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

      def recurring_donation_path(id = nil)
        id ? "FinancialScheduledTransactions/#{id}" : 'FinancialScheduledTransactions'
      end
    end
  end
end

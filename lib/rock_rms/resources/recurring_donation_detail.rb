# frozen_string_literal: true

module RockRMS
  class Client
    module RecurringDonationDetail
      def create_recurring_donation_detail(
        recurring_donation_id:,
        fee_coverage_amount: nil,
        entity_type_id: nil,
        entity_id: nil,
        fund_id:,
        amount:
      )
        options = {
          'AccountId' => fund_id,
          'Amount' => amount,
          'ScheduledTransactionId' => recurring_donation_id
        }

        options['FeeCoverageAmount'] = fee_coverage_amount if fee_coverage_amount
        options['EntityTypeId'] = entity_type_id if entity_type_id
        options['EntityId'] = entity_id if entity_id

        post(recurring_donation_detail_path, options)
      end

      def delete_recurring_donation_detail(id)
        delete(recurring_donation_detail_path(id))
      end

      def update_recurring_donation_detail(id, fund_id: nil, amount: nil, fee_coverage_amount: nil, entity_type_id: nil, entity_id: nil)
        options = {}
        options['AccountId'] = fund_id if fund_id
        options['Amount']    = amount  if amount
        options['FeeCoverageAmount'] = fee_coverage_amount if fee_coverage_amount
        options['EntityTypeId'] = entity_type_id if entity_type_id
        options['EntityId'] = entity_id if entity_id

        patch(recurring_donation_detail_path(id), options)
      end

      private

      def recurring_donation_detail_path(id = nil)
        id ? "FinancialScheduledTransactionDetails/#{id}" : 'FinancialScheduledTransactionDetails'
      end
    end
  end
end

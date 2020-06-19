module RockRMS
  class Client
    module RecurringDonationDetail
      def update_recurring_donation_detail(id, fund_id: nil, amount: nil)
        options = {}
        options['AccountId'] = fund_id if fund_id
        options['Amount']    = amount  if amount

        patch(recurring_donation_detail_path(id), options)
      end

      private

      def recurring_donation_detail_path(id = nil)
        id ? "FinancialScheduledTransactionDetails/#{id}" : 'FinancialScheduledTransactionDetails'
      end
    end
  end
end

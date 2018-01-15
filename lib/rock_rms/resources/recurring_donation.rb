module RockRMS
  class Client
    module RecurringDonation
      def list_recurring_donations(options = {})
        res = get(recurring_donation_path, options)
        RockRMS::RecurringDonation.format(res)
      end

      def find_recurring_donation(id)
        res = get(recurring_donation_path(id))
        RockRMS::RecurringDonation.format(res)
      end

      private

      def recurring_donation_path(id = nil)
        id ? "FinancialScheduledTransactions/#{id}" : 'FinancialScheduledTransactions'
      end
    end
  end
end

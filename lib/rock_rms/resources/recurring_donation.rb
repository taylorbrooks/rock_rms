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

      def update_recurring_donation(
        id,
        next_payment_date:,
        transaction_code: nil
      )
        options = { 'NextPaymentDate' => next_payment_date }
        options['TransactionCode'] = transaction_code if transaction_code

        patch(recurring_donation_path(id), options)
      end

      private

      def recurring_donation_path(id = nil)
        id ? "FinancialScheduledTransactions/#{id}" : 'FinancialScheduledTransactions'
      end
    end
  end
end

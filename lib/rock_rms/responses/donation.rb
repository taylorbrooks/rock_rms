module RockRMS
  module Responses
    class Donation
      def self.format(response)
        if response.is_a?(Array)
          response.map { |donation| format_donation(donation) }
        else
          format_donation(response)
        end
      end

      def self.format_donation(donation)
        {
          id:     donation['Id'],
          date:   donation['TransactionDateTime'],
          amount: donation['TransactionDetails'].reduce(0) { |sum, td| sum + td['Amount'] },
          person_id: donation['AuthorizedPersonAliasId'],
          fund:   '',
          batch_id: donation['BatchId'],
          scheduled_transaction_id: donation['ScheduledTransactionId'],
          summary: donation['Summary']
        }
      end
    end
  end
end

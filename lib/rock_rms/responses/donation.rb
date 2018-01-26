module RockRMS
  module Responses
    class Donation
      MAP = {
        id: 'Id',
        date: 'TransactionDateTime',
        person_id: 'AuthorizedPersonAliasId',
        batch_id: 'BatchId',
        recurring_donation_id: 'ScheduledTransactionId',
        summary: 'Summary',
        transaction_code: 'TransactionCode',
        details: 'TransactionDetails'
      }.freeze

      def self.format(response)
        if response.is_a?(Array)
          response.map { |data| format_single(data) }
        else
          format_single(response)
        end
      end

      def self.format_single(data)
        response = MAP.each.with_object({}) do |(l, r), object|
          object[l] = if l == :details
                        RockRMS::Responses::TransactionDetail.format(data[r])
                      else
                        data[r]
                      end
        end
        response[:amount] = calculate_total(response[:details])
        response
      end

      def self.calculate_total(details)
        details.reduce(0) { |sum, td| sum + td[:amount] }
      end
    end
  end
end

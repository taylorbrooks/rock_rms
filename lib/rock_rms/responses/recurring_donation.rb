module RockRMS
  module Responses
    class RecurringDonation
      MAP = {
        id: 'Id',
        person_id: 'AuthorizedPersonAliasId',
        transaction_details: 'ScheduledTransactionDetails'
      }.freeze

      def self.format(data)
        if data.is_a?(Array)
          data.map { |object| format_single(object) }
        else
          format_single(data)
        end
      end

      def self.format_single(data)
        MAP.each.with_object({}) do |(l, r), object|
          object[l] = if l == :transaction_details
                        RockRMS::RecurringDonationDetails.format(data[r])
                      else
                        data[r]
                      end
        end
      end
    end
  end
end

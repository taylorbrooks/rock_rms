module RockRMS
  module Response
    class RecurringDonationDetails < Base
      MAP = {
        amount: 'Amount',
        fund_id: 'AccountId',
        id: 'Id'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

module RockRMS
  module Response
    class RegistrationInstance < Base
      MAP = {
        name: 'Name',
        start_date: 'StartDateTime',
        end_date: 'EndDateTime',
        fund_id: 'AccountId'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response
      end
    end
  end
end

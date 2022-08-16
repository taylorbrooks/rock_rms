module RockRMS
  module Response
    class ServiceJob < Base
      MAP = {
        name: 'Name',
        active: 'IsActive',
        description: 'Description',
        cron: 'CronExpression'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

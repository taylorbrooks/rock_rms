module RockRMS
  module Response
    class ServiceJob < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        active: 'IsActive',
        description: 'Description',
        cron: 'CronExpression'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

module RockRMS
  module Response
    class WorkflowType < Base
      MAP = {
        id: 'Id',
        active: 'IsActive',
        name: 'Name',
        description: 'Description',
        summary: 'SummaryViewText',
        activities: 'ActivityTypes'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:activities] = WorkflowActivityType.format(response[:activities])
        response
      end
    end
  end
end

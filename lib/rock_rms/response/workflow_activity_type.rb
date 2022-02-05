module RockRMS
  module Response
    class WorkflowActivityType < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        description: 'Description',
        order: 'Order',
        actions: 'ActionTypes',
        workflow_type_id: 'WorkflowTypeId'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:actions] = WorkflowActionType.format(response[:actions])
        response
      end
    end
  end
end

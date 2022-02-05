module RockRMS
  module Response
    class WorkflowActionType < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        activity_type_id: 'ActivityTypeId',
        order: 'Order'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

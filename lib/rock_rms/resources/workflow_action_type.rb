module RockRMS
  class Client
    module WorkflowActionType
      PATH = 'WorkflowActionTypes'.freeze

      def list_workflow_action_types(options = {})
        res = get(PATH)
        Response::WorkflowActionType.format(res)
      end

      def find_workflow_action_type(id)
        res = get(PATH + "/#{id}")
        Response::WorkflowActionType.format(res)
      end
    end
  end
end

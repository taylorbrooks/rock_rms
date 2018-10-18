module RockRMS
  class Client
    module WorkflowActivityType
      PATH = 'WorkflowActivityTypes'.freeze

      def list_workflow_activity_types(options = {})
        res = get(PATH, options)
        Response::WorkflowActivityType.format(res)
      end

      def find_workflow_activity_type(id)
        res = get(PATH + "/#{id}")
        Response::WorkflowActivityType.format(res)
      end
    end
  end
end

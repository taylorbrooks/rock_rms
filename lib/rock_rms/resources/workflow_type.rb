module RockRMS
  class Client
    module WorkflowType
      PATH = 'WorkflowTypes'.freeze

      def list_workflow_types(options = {})
        res = get(PATH, options)
        Response::WorkflowType.format(res)
      end

      def find_workflow_type(id)
        res = get(PATH + "/#{id}")
        Response::WorkflowType.format(res)
      end
    end
  end
end

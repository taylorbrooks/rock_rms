module RockRMS
  class Client
    module BlockType
      def list_block_types(options = {})
        res = get(block_type_path, options)
        Response::BlockType.format(res)
      end

      def delete_block_type(id)
        delete(block_type_path(id))
      end

      def block_type_path(id = nil)
        id ? "BlockTypes/#{id}" : 'BlockTypes'
      end
    end
  end
end

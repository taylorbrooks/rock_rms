module RockRMS
  class Client
    module Block
      def list_blocks(options = {})
        res = get(block_path, options)
        Response::Block.format(res)
      end

      def block_path(id = nil)
        id ? "Blocks/#{id}" : 'Blocks'
      end
    end
  end
end

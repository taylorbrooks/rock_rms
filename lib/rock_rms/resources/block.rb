module RockRMS
  class Client
    module Block
      def list_blocks(options = {})
        res = get(block_path, options)
        Response::Block.format(res)
      end

      def create_block(
        block_type_id:,
        name:,
        order:,
        page_id:,
        zone:
      )
        options = {
          'BlockTypeId' => block_type_id,
          'Name' => name,
          'Order' => order,
          'PageId' => page_id,
          'Zone' => zone
        }

        post(block_path, options)
      end

      def delete_block(id)
        delete(block_path(id))
      end

      def block_path(id = nil)
        id ? "Blocks/#{id}" : 'Blocks'
      end
    end
  end
end

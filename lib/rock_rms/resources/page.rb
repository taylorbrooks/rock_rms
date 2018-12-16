module RockRMS
  class Client
    module Page
      def list_pages(options = {})
        res = get(page_path, options)
        Response::Page.format(res)
      end

      def page_path(id = nil)
        id ? "Pages/#{id}" : 'Pages'
      end
    end
  end
end

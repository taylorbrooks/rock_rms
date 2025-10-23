
module RockRMS
  class Client
    module HtmlContent
      def create_html_content(
        block_id:,
        content:
      )
        options = {
          'BlockId' => block_id,
          'Content' => content
        }

        post(html_content_path, options)
      end

      def html_content_path(id = nil)
        id ? "HtmlContents/#{id}" : 'HtmlContents'
      end
    end
  end
end

module RockRMS
  class Client
    module Lava
      def render_template(options = {})
        post('Lava/RenderTemplate', options)
      end
    end
  end
end

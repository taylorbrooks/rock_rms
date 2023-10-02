module RockRMS
  module Response
    class LavaShortcode < Base
      MAP = {
        name: 'Name',
        description: 'Description',
        documentation: 'Documentation',
        active: 'IsActive',
        is_system: 'IsSystem',
        tag_name: 'TagName',
        markup: 'Markup',
        parameters: 'Parameters'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

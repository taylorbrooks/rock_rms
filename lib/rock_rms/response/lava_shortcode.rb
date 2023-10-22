module RockRMS
  module Response
    class LavaShortcode < Base
      MAP = {
        name: 'Name',
        description: 'Description',
        documentation: 'Documentation',
        active: 'IsActive',
        is_system: 'IsSystem',
        enabled_lava_commands: 'EnabledLavaCommands',
        tag_name: 'TagName',
        tag_type: 'TagType',
        markup: 'Markup',
        parameters: 'Parameters'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

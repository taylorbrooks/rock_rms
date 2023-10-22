module RockRMS
  class Client
    module LavaShortcode
      def list_lava_shortcodes(options = {})
        res = get(lava_shortcodes_path, options)
        Response::LavaShortcode.format(res)
      end

      def find_lava_shortcode(id)
        res = get(lava_shortcodes_path(id))
        Response::LavaShortcode.format(res)
      end

      def create_lava_shortcode(
        name:,
        description:,
        documentation:,
        active:,
        is_system:,
        markup:,
        enabled_lava_commands:,
        parameters:,
        tag_name:,
        tag_type:
      )
        options = {
          'Name' => name,
          'Description' => description,
          'Documentation' => documentation,
          'IsActive' => active,
          'IsSystem' => is_system,
          'Markup' => markup,
          'EnabledLavaCommands' => enabled_lava_commands,
          'Parameters' => parameters,
          'TagName' => tag_name,
          'TagType' => tag_type,
        }

        post(lava_shortcodes_path, options)
      end

      def update_lava_shortcode(
        id,
        name: nil,
        description: nil,
        documentation: nil,
        active: nil,
        is_system: nil,
        markup: nil,
        enabled_lava_commands: nil,
        parameters: nil,
        tag_name: nil,
        tag_type: nil
      )

        options = {}

        options['Name']          = name          if name
        options['Description']   = description   if description
        options['Documentation'] = documentation if documentation
        options['IsActive']      = active        if active
        options['IsSystem']      = is_system     if is_system
        options['Markup']        = markup        if markup
        options['Parameters']    = parameters    if parameters
        options['TagName']       = tag_name      if tag_name
        options['TagType']       = tag_type      if tag_type
        options['EnabledLavaCommands'] = enabled_lava_commands if enabled_lava_commands

        patch(lava_shortcodes_path(id), options)
      end

      private

      def lava_shortcodes_path(id = nil)
        id ? "LavaShortcodes/#{id}" : 'LavaShortcodes'
      end
    end
  end
end

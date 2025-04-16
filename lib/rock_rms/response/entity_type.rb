module RockRMS
  module Response
    class EntityType < Base
      MAP = {
        name: 'Name',
        friendly_name: 'FriendlyName',
        is_entity: 'IsEntity',
        is_secured: 'IsSecured'
      }.freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:blocks] = Block.format(response[:blocks])
        response
      end
    end
  end
end

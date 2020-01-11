module RockRMS
  module Response
    class UserLogin < Base
      MAP = {
        entity_type_id: 'EntityTypeId',
        is_confirmed: 'IsConfirmed',
        person_id: 'PersonId',
        username: 'UserName',
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end

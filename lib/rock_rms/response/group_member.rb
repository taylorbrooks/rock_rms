module RockRMS
  module Response
    class GroupMember < Base
      MAP = {
        person: 'Person',
        group_id: 'GroupId',
      }.freeze

      def format_single(data)
        response                   = to_h(MAP, data)
        response[:person]          = format_person(response[:person])
        response
      end

      def format_person(res)
        return res if res.nil?
        Person.format(res)
      end

    end
  end
end

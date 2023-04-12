module RockRMS
  module Response
    class GroupMember < Base
      
      def format_single(data)
        Person.format(data)
      end

    end
  end
end

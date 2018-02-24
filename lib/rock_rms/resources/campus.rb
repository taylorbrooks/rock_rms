module RockRMS
  class Client
    module Campus

      def find_campus(id)
        Response::Campus.format(get(campus_path(id)))
      end

      private

      def campus_path(id = nil)
        id ? "Campuses/#{id}" : 'Campus'
      end
    end
  end
end

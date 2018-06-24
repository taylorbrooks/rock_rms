module RockRMS
  class Client
    module Utility
      def find_rock_version
        get('Utility/GetRockSemanticVersionNumber')
      end
    end
  end
end

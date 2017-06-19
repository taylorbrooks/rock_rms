module RockRMS
  class Fund
    def self.format(response)
      if response.is_a?(Array)
        response.map{|fund| format_fund(fund) }
      else
        format_fund(response)
      end
    end

    def self.format_fund(fund)
      {
        id:   fund["Id"],
        name: fund["Name"]
      }
    end
  end
end

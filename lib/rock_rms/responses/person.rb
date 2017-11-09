module RockRMS
  class Person
    def self.format(response)
      if response.is_a?(Array)
        response.map { |person| format_person(person) }
      else
        format_person(response)
      end
    end

    def self.format_person(person)
      {
        id:         person['Id'],
        name:       person['FullName'],
        email:      person['Email'],
        first_name: person['FirstName'],
        last_name:  person['LastName'],
        giving_id:  person['GivingId'],
        alias_id:   person['PrimaryAliasId']
      }
    end
  end
end

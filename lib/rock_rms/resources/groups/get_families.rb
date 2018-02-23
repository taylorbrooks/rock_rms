module RockRMS
  class Client
    module Groups
      module GetFamilies

        def find_person_families(id)
          res = get(get_families_path(id))

          Response::Group.format(res)
        end

        private

        def get_families_path(id)
          "Groups/GetFamilies/#{id}"
        end
      end
    end
  end
end

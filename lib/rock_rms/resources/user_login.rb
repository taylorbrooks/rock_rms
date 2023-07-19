module RockRMS
  class Client
    module UserLogin
      def list_user_logins(options = {})
        res = get('UserLogins', options)
        Response::UserLogin.format(res)
      end

      def create_user_login(
        api_key: nil,
        username:,
        password: nil,
        person_id:,
        is_confirmed: false
      )
        options = {
          'ApiKey' => api_key,
          'UserName' => username,
          'PersonId' => person_id,
          'EntityTypeId' => 27,
          'IsConfirmed' => is_confirmed,
          'IsLockedOut' => false,
          'IsPasswordChangeRequired' => true,
          'LastPasswordChangedDateTime' => Time.now,
          'PlainTextPassword' => password,
        }

        post('UserLogins', options)
      end

      def update_user_login(id, options)
        patch("UserLogins/#{id}", options)
      end
    end
  end
end

module RockRMS
  class Client
    module UserLogin
      def list_user_logins(options = {})
        res = get('UserLogins', options)
        Response::UserLogin.format(res)
      end

      def create_user_login(
        username:,
        password:,
        person_id:,
        is_confirmed: false
      )
        options = {
          'UserName' => username,
          'PersonId' => person_id,
          'EntityTypeId' => 27,
          'IsConfirmed' => false,
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

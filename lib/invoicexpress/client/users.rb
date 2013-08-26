module Invoicexpress
  class Client
    module Users

      # This endpoint does not require an API KEY to be acessible.
      # Instead it requires your current login and password.
      # Upon successful login it will return all the accounts which belong to you
      #
      # @param login [String] Login email
      # @param password [String] Your password
      # @return [Array<Invoicexpress::Models::Account>] The list of your accounts
      # @raise Invoicexpress::Unauthorized When the login/password combination is wrong
      def login(login, password, options={})
        credentials = Invoicexpress::Models::Credentials.new(
          :login => login,
          :password => password
        )

        params = { :klass => Invoicexpress::Models::Account, :body => credentials }
        post("login.xml", params.merge(options))
      end

      # This method allows you to view your accounts.
      #
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @return [Array<Invoicexpress::Models::Account>] The list of accounts
      def accounts(options = {})
        params = { :klass => Invoicexpress::Models::Account }
        get("users/accounts.xml", params.merge(options))
      end

      # Changes the current account to the account id submitte
      #
      # @param account_id [String] The account ID to change to
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotFound When the account doesn't exist
      def change_account(account_id, options={})
        change_account_to = Invoicexpress::Models::ChangeAccountTo.new(
          :id => account_id
        )

        params = { :klass => Invoicexpress::Models::Account, :body => change_account_to }
        put("users/change-account.xml", params.merge(options))
      end

    end
  end
end

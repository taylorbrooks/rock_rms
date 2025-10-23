require 'faraday'
require 'faraday/multipart'

Dir[File.expand_path('../resources/*.rb', __FILE__)].each { |f| require f }
require File.expand_path('../response/base.rb', __FILE__)
require File.expand_path('../transform_hash_keys.rb', __FILE__)
require File.expand_path('../recurring_frequencies.rb', __FILE__)
Dir[File.expand_path('../response/*.rb', __FILE__)].each { |f| require f }

module RockRMS
  class Client
    include TransformHashKeys
    include RecurringFrequencies
    include RockRMS::Client::Attribute
    include RockRMS::Client::AttributeValue
    include RockRMS::Client::Batch
    include RockRMS::Client::BinaryFile
    include RockRMS::Client::Block
    include RockRMS::Client::BlockAction
    include RockRMS::Client::BlockType
    include RockRMS::Client::Fund
    include RockRMS::Client::Campus
    include RockRMS::Client::ContentChannel
    include RockRMS::Client::ContentChannelType
    include RockRMS::Client::ContentChannelItem
    include RockRMS::Client::DefinedType
    include RockRMS::Client::DefinedValue
    include RockRMS::Client::EntityType
    include RockRMS::Client::ExceptionLog
    include RockRMS::Client::Gateway
    include RockRMS::Client::Group
    include RockRMS::Client::GroupMember
    include RockRMS::Client::History
    include RockRMS::Client::HtmlContent
    include RockRMS::Client::Lava
    include RockRMS::Client::LavaShortcode
    include RockRMS::Client::Page
    include RockRMS::Client::PaymentDetail
    include RockRMS::Client::Person
    include RockRMS::Client::PhoneNumber
    include RockRMS::Client::RecurringDonation
    include RockRMS::Client::RecurringDonationDetail
    include RockRMS::Client::Refund
    include RockRMS::Client::RefundReason
    include RockRMS::Client::Registration
    include RockRMS::Client::RegistrationSession
    include RockRMS::Client::SavedPaymentMethod
    include RockRMS::Client::ServiceJob
    include RockRMS::Client::SystemCommunication
    include RockRMS::Client::SystemEmail
    include RockRMS::Client::Transaction
    include RockRMS::Client::TransactionDetail
    include RockRMS::Client::TransactionImage
    include RockRMS::Client::UserLogin
    include RockRMS::Client::Utility
    include RockRMS::Client::WorkflowActionType
    include RockRMS::Client::WorkflowActivityType
    include RockRMS::Client::WorkflowType

    attr_reader :url, :username, :password, :logger, :cookie, :connection, :adapter, :ssl, :authorization_token, :proxy

    def initialize(url:, username: nil, password: nil, authorization_token: nil, logger: true, adapter: Faraday.default_adapter, ssl: nil, proxy: nil)
      if username.nil? && password.nil? && authorization_token.nil?
        raise ArgumentError, 'either username and password or authorization_token is required'
      end

      @url      = "#{url}/api/"
      @username = username unless authorization_token
      @password = password unless authorization_token
      @authorization_token = authorization_token unless username && password
      @logger   = logger
      @adapter  = adapter
      @ssl      = ssl
      @proxy    = proxy
      @cookie   = auth['set-cookie'] unless auth.nil?
    end

    def delete(path, options = {})
      connection.delete(path, options).body
    end

    def get(path, options = {})
      connection.get(path, options).body
    end

    def patch(path, options = {})
      connection.patch(path, options).body
    end

    def post(path, options = {})
      connection.post(path, options).body
    end

    def put(path, options = {})
      connection.put(path, options).body
    end

    private

    def auth
      return nil if username.nil? && password.nil?

      begin
        auth_request('Auth/Login')
      rescue Faraday::ParsingError => e
        if e.message.include?('Document Moved')
          auth_request('auth/login')
        else
          raise e
        end
      end
    end

    def auth_request(path)
      connection.post(
        path,
        'Username'  => username,
        'Password'  => password,
        'Persisted' => true
      )
    end

    def connection
      headers = {
        accept: 'application/json',
        'User-Agent' => "rock-rms-ruby-gem/v#{RockRMS::VERSION}"
      }

      headers['Cookie'] = cookie if cookie
      headers['Authorization-Token'] = authorization_token if authorization_token

      client_opts = {
        url: url,
        headers: headers
      }

      client_opts[:ssl] = ssl if ssl
      client_opts[:proxy] = proxy if proxy

      Faraday.new(client_opts) do |conn|
        conn.request   :multipart
        conn.request   :json
        conn.response  :logger if logger
        conn.response  :oj
        conn.use       FaradayMiddleware::RockRMSErrorHandler
        conn.adapter   adapter
      end
    end
  end
end

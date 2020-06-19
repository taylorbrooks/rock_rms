require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/parse_oj'

Dir[File.expand_path('../resources/*.rb', __FILE__)].each { |f| require f }
require File.expand_path('../response/base.rb', __FILE__)
require File.expand_path('../recurring_frequencies.rb', __FILE__)
Dir[File.expand_path('../response/*.rb', __FILE__)].each { |f| require f }

module RockRMS
  class Client
    include RecurringFrequencies
    include RockRMS::Client::Attribute
    include RockRMS::Client::AttributeValue
    include RockRMS::Client::Batch
    include RockRMS::Client::Block
    include RockRMS::Client::BlockType
    include RockRMS::Client::Fund
    include RockRMS::Client::Campus
    include RockRMS::Client::DefinedType
    include RockRMS::Client::DefinedValue
    include RockRMS::Client::Gateway
    include RockRMS::Client::Group
    include RockRMS::Client::GroupMember
    include RockRMS::Client::Page
    include RockRMS::Client::PaymentDetail
    include RockRMS::Client::Person
    include RockRMS::Client::PhoneNumber
    include RockRMS::Client::RecurringDonation
    include RockRMS::Client::RecurringDonationDetail
    include RockRMS::Client::Refund
    include RockRMS::Client::RefundReason
    include RockRMS::Client::SavedPaymentMethod
    include RockRMS::Client::Transaction
    include RockRMS::Client::TransactionDetail
    include RockRMS::Client::UserLogin
    include RockRMS::Client::Utility
    include RockRMS::Client::WorkflowActionType
    include RockRMS::Client::WorkflowActivityType
    include RockRMS::Client::WorkflowType

    attr_reader :url, :username, :password, :logger, :cookie, :connection, :adapter

    def initialize(url:, username:, password:, logger: true, adapter: Faraday.default_adapter)
      @url      = "#{url}/api/"
      @username = username
      @password = password
      @logger   = logger
      @adapter  = adapter
      @cookie   = auth['set-cookie']
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
      connection.post(
        'Auth/Login',
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

      Faraday.new(url: url, headers: headers) do |conn|
        conn.request   :json
        conn.response  :logger if logger
        conn.response  :oj
        conn.use       FaradayMiddleware::RockRMSErrorHandler
        conn.adapter   adapter
      end
    end
  end
end

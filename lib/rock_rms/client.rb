require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/parse_oj'

Dir[File.expand_path('../resources/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../responses/*.rb', __FILE__)].each { |f| require f }

module RockRMS
  class Client
    include RockRMS::Client::Batch
    include RockRMS::Client::Donation
    include RockRMS::Client::Fund
    include RockRMS::Client::Group
    include RockRMS::Client::PaymentMethod
    include RockRMS::Client::Person
    include RockRMS::Client::TransactionDetail

    attr_reader :url, :username, :password, :logger, :cookie, :connection

    def initialize(url:, username:, password:, logger: true)
      @url      = "#{url}/api/"
      @username = username
      @password = password
      @logger   = logger
      @cookie   = auth['set-cookie']
    end

    def delete(path, options = {})
      connection.delete(path, options).body
    end

    def get(path, options = {})
      connection.get(path, options).body
    end

    def patch(path, req_body)
      connection.patch(path, req_body).body
    end

    def post(path, req_body)
      connection.post(path, req_body).body
    end

    def put(path, req_body)
      connection.put(path, req_body).body
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
        conn.adapter   Faraday.default_adapter
      end
    end
  end
end

module RockRMS
  class Error < StandardError; end
end

require 'faraday'
module FaradayMiddleware
  class RockRMSErrorHandler < Faraday::Response::Middleware
    ERROR_STATUSES = 400..600

    def on_complete(env)
      case env[:status]
      when ERROR_STATUSES
        raise RockRMS::Error, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      end
    end
  end
end

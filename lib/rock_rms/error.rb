module RockRMS
  class Error < StandardError; end
end

require "faraday"
module FaradayMiddleware
  class RockRMSErrorHandler < Faraday::Response::Middleware
    ERROR_STATUSES = 400..600
    def on_complete(env)
      case env[:status]
      when ERROR_STATUSES
        raise Closeio::Error, "#{env.status}: #{env.body}"
      end
    end
  end
end

module RockRMS
  class Error < StandardError; end
  class BadGateway < Error; end
  class BadRequest < Error; end
  class Forbidden < Error; end
  class GatewayTimeout < Error; end
  class InternalServerError < Error; end
  class NotFound < Error; end
  class ServiceUnavailable < Error; end
  class Unauthorized < Error; end
end

require 'faraday'
module FaradayMiddleware
  class RockRMSErrorHandler < Faraday::Response::Middleware
    ERROR_STATUSES = 400..600

    def on_complete(env)
      case env[:status]
      when 400
        raise RockRMS::BadRequest, error_message(env)
      when 401
        raise RockRMS::Unauthorized, error_message(env)
      when 403
        raise RockRMS::Forbidden, error_message(env)
      when 404
        raise RockRMS::NotFound, error_message(env)
      when 500
        raise RockRMS::InternalServerError, error_message(env)
      when 502
        raise RockRMS::BadGateway, error_message(env)
      when 503
        raise RockRMS::ServiceUnavailable, error_message(env)
      when 504
        raise RockRMS::GatewayTimeout, error_message(env)
      when ERROR_STATUSES
        raise RockRMS::Error, error_message(env)
      end
    end

    private

    def error_message(env)
      "#{env[:status]}: #{env[:url]} #{env[:body]}"
    end
  end
end

module RockRMS
  class Error < StandardError; end
  class BadRequest < Error; end
  class Forbidden < Error; end
  class GatewayTimeout < Error; end
  class InternalServerError < Error; end
  class NotFound < Error; end
  class Unauthorized < Error; end
end

require 'faraday'
module FaradayMiddleware
  class RockRMSErrorHandler < Faraday::Response::Middleware
    ERROR_STATUSES = 400..600

    def on_complete(env)
      case env[:status]
      when 400
        raise RockRMS::BadRequest, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when 401
        raise RockRMS::Unauthorized, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when 403
        raise RockRMS::Forbidden, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when 404
        raise RockRMS::NotFound, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when 500
        raise RockRMS::InternalServerError, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when 504
        raise RockRMS::GatewayTimeout, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      when ERROR_STATUSES
        raise RockRMS::Error, "#{env[:status]}: #{env[:body]} #{env[:url]}"
      end
    end
  end
end

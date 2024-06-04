module RockRMS
  class Error < StandardError; end
  class BadGateway < Error; end
  class BadRequest < Error; end
  class CloudflareError < Error; end
  class Forbidden < Error; end
  class GatewayTimeout < Error; end
  class InternalServerError < Error; end
  class NotFound < Error; end
  class ServiceUnavailable < Error; end
  class Unauthorized < Error; end
end

require 'faraday'
module FaradayMiddleware
  class RockRMSErrorHandler < Faraday::Middleware
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
      when 520
        raise RockRMS::CloudflareError, error_message(env)
      when 522
        raise RockRMS::CloudflareError, error_message(env)
      when ERROR_STATUSES
        raise RockRMS::Error, error_message(env)
      end

      check_html_error(env)
    end

    private

    def html_body?(body)
      body.lstrip.start_with?('<!DOCTYPE html>')
    end

    def check_html_error(env)
      return unless html_body?(env[:body])

      return unless /An error has occurred while processing your request/ =~ env[:body]

      raise RockRMS::InternalServerError, error_message(
        status: 500, url: env[:url], body: 'Unknown API error.'
      )
    end

    def error_message(env)
      "#{env[:status]}: #{env[:url]} #{env[:body]}"
    end
  end
end

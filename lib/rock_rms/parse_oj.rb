require 'oj'

module FaradayMiddleware
  class ParseOj < Faraday::Middleware
    def on_complete(env)
      if empty_body?(env[:body].strip)
        env[:body] = nil
      elsif html_body?(env[:body])
        env[:body] = env[:body]
      else
        env[:body] = Oj.load(env[:body], mode: :compat)
      end
    end

    private

    def html_body?(body)
      body.start_with?('<!DOCTYPE html>')
    end

    def empty_body?(body)
      body.empty? && body == ''
    end
  end
end

Faraday::Response.register_middleware(oj: FaradayMiddleware::ParseOj)

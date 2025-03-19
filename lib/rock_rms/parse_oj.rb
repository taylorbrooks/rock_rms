require 'oj'

module FaradayMiddleware
  class ParseOj < Faraday::Middleware
    def on_complete(env)
      if empty_body?(env[:body].strip)
        env[:body] = nil
      elsif html_body?(env[:body])
        env[:body] = env[:body]
      elsif gzip_body?(env[:response_headers])
        uncompressed_body = Zlib::GzipReader.new(StringIO.new(env[:body])).read
        env[:body] = Oj.load(uncompressed_body, mode: :compat)
      else
        env[:body] = Oj.load(env[:body], mode: :compat)
      end
    end

    private

    def gzip_body?(headers)
      headers['content-type'] == 'application/gzip'
    end

    def html_body?(body)
      /(<!DOCTYPE html>)|(<html>)/ =~ body
    end

    def empty_body?(body)
      body.empty? && body == ''
    end
  end
end

Faraday::Response.register_middleware(oj: FaradayMiddleware::ParseOj)

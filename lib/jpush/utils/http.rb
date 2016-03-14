require 'net/http'

module Jpush
  module Utils
    class Http

      HTTP_VERB_MAP = {
        get:    Net::HTTP::Get,
        post:   Net::HTTP::Post,
        put:    Net::HTTP::Put,
        delete: Net::HTTP::Delete
      }

      def initialize(method, url, params: nil, body: nil, headers: nil)
        method = method.downcase.to_sym
        raise "ERROR http method #{method.upcase} is invalid!" unless HTTP_VERB_MAP.keys.include?(method)
        @uri = URI(url)
        @uri.query = URI.encode_www_form(params) unless params.nil?
        @request = prepare_request(method, body)
      end

      def send_request
        Net::HTTP.start(@uri.host, @uri.port, use_ssl: 'https' == @uri.scheme) do |http|
          http.request(@request)
        end
      end

      def basic_auth(user, password)
        @request.basic_auth(user, password)
        self
      end

      private

        def prepare_request(method, body)
          request = HTTP_VERB_MAP[method].new @uri
          request.body = body.to_json unless body.nil?
          request
        end

    end
  end
end

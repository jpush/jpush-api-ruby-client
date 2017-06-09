require_relative 'response'
require 'net/http'
require 'net-http2'
require "base64"
require 'json'
require 'jpush/utils/exceptions'

module JPush
  module Http
    class Client

      class << self

        def get(jpush, url, params: nil, headers: {})
          request(jpush, :get, url, params: params, headers: headers)
        end

        def post(jpush, url, body: , headers: {})
          request(jpush, :post, url, body: body, headers: headers)
        end

        def put(jpush, url, body: , headers: {})
          request(jpush, :put, url, body: body, headers: headers)
        end

        def delete(jpush, url, params: nil, headers: {})
          request(jpush, :delete, url, params: params, headers: headers)
        end

        def request(jpush, method, url, params: nil, body: nil, headers: {}, opts: {})
          raw_response = self.new(
            jpush,
            method,
            url,
            params: params,
            body: body,
            headers: headers,
            opts: opts
          ).send_request

          Response.new(raw_response)
        end

      end

      DEFAULT_USER_AGENT = 'jpush-api-ruby-client/' + JPush::VERSION
      DEFAULT_OPEN_TIMEOUT = 20
      DEFAULT_READ_TIMEOUT = 120
      DEFAULT_RETRY_TIMES = 3
      RETRY_SLEEP_TIME = 3

      DEFAULT_HEADERS = {
        'user-agent' => DEFAULT_USER_AGENT,
        'accept' => 'application/json',
        'content-type' => 'application/json',
        'connection' => 'close'
      }

      def initialize(jpush, method, url, params: nil, body: nil, headers: {}, opts: {})
        @uri = URI(url)
        @method = method.downcase.to_sym
        @params = params
        @body = body.to_json unless body.nil?
        @headers = DEFAULT_HEADERS.merge(headers)
        @headers['Authorization'] = 'Basic ' + Base64.encode64(jpush.app_key + ':' + jpush.master_secret).gsub("\n", '')
        @opts = opts
      end

      def send_request
        opts ||=  {
          use_ssl: 'https' == @uri.scheme,
          open_timeout: DEFAULT_OPEN_TIMEOUT,
          read_timeout: DEFAULT_READ_TIMEOUT
        }.merge @opts

        uri = @uri.scheme + '://' + @uri.host
        @client = NetHttp2::Client.new(uri)

        response = @client.call(@method, @uri.path, params: @params, body: @body, headers: @headers)
        @client.close
        response
      end
    end
  end
end

require_relative 'response'

module Jpush
  module Http
    module Client
      extend self

      def get(url, params: nil, headers: {})
        send_request(:get, url, params: params, headers: headers)
      end

      def post(url, body: , headers: {})
        send_request(:post, url, body: body, headers: headers)
      end

      def delete(url, params: nil, headers: {})
        send_request(:delete, url, params: params, headers: headers)
      end

      def send_request(method, url, params: nil, body: nil, headers: {})
        headers = jpush_headers.merge(headers)
        raw_response =
          Utils::Http.new(method.to_sym, url, params: params, body: body, headers: headers).
          basic_auth(jpush_basic_auth[:user], jpush_basic_auth[:pass]).
          send_request

        if raw_response.kind_of? Net::HTTPSuccess
          Response.new(raw_response.code, raw_response.body)
        else
          raise Utils::Exceptions::JpushResponseError.new(raw_response)
        end
      end

      private

        def jpush_basic_auth
          {
            user: Config.settings[:app_key],
            pass: Config.settings[:master_secret]
          }
        end

        def jpush_headers
          {
            'user-agent' => 'jpush-ruby-sdk-client/' + Jpush::VERSION,
            'accept' => 'application/json',
            'content-type' => 'application/json',
            'connection' => 'close'
          }
        end

    end
  end
end

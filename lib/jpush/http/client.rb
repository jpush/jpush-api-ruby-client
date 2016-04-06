require_relative 'response'

module Jpush
  module Http
    module Client
      extend self

      def get(url, params: nil)
        send_request(:get, url, params: params)
      end

      def post(url, body:)
        send_request(:post, url, body: body)
      end

      def delete(url, params: nil)
        send_request(:delete, url, params: params)
      end

      def send_request(method, url, params: nil, body: nil)
        raw_response =
          Utils::Http.new(method.to_sym, url, params: params, body: body).
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
            accept: 'application/json'
          }
        end

    end
  end
end

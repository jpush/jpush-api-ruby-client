module Jpush
  module Http
    module Client
      extend self

      def get(url, params: nil)
        Utils::Http.new(:get, url, params: params).
          basic_auth(jpush_basic_auth[:user], jpush_basic_auth[:pass]).
          send_request
      end

      def post(url, body:)
        Utils::Http.new(:post, url, body: body).
        basic_auth(jpush_basic_auth[:user], jpush_basic_auth[:pass]).
        send_request
      end

      def delete(url, params: nil)
        Utils::Http.new(:delete, url, params: params).
        basic_auth(jpush_basic_auth[:user], jpush_basic_auth[:pass]).
        send_request
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

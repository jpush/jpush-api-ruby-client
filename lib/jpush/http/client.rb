require_relative 'response'

module JPush
  module Http
    module Client
      extend self

      def get(url, params: nil, headers: {})
        send_request(:get, url, params: params, headers: headers)
      end

      def post(url, body: , headers: {})
        send_request(:post, url, body: body, headers: headers)
      end

      def put(url, body: , headers: {})
        send_request(:put, url, body: body, headers: headers)
      end

      def delete(url, params: nil, headers: {})
        send_request(:delete, url, params: params, headers: headers)
      end

      def send_request(method, url, params: nil, body: nil, headers: {}, opts: {})
        raw_response = Utils::Http.new(
          method.to_sym,
          url,
          params: params,
          body: body,
          headers: headers,
          opts: opts
        ).basic_auth.send_request

        Response.new(raw_response)
      end

    end
  end
end

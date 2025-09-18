module JPush
  module Http
    class Response

      attr_accessor :http_code, :body, :heades

      def initialize(raw_response)
        @http_code = raw_response.code.to_i
        @body = parse_body(raw_response.body)
        build_error unless raw_response.kind_of? Net::HTTPSuccess
      end

      private

        def parse_body(body)
          parsed_body = JSON.parse(body)
          return parsed_body
        rescue JSON::ParserError
          raise Utils::Exceptions::JPushResponseError.new(http_code, http_code, body)
        end

        def build_error
          error_code, error_message =
            if @body.has_key?('error')
              [@body['error']['code'], @body['error']['message']]
            else
              [@body['code'], @body['message']]
            end
          raise Utils::Exceptions::JPushResponseError.new(http_code, error_code, error_message)
        end

    end
  end
end

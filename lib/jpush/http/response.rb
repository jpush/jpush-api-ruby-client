module Jpush
  module Http
    class Response

      attr_accessor :http_code, :body, :heades, :error

      def initialize(http_code, body, bool_error)
        @http_code = http_code.to_i
        @body = parse_body(body)
        @error = build_error(bool_error)
      end

      private

        def parse_body(body)
          body = JSON.parse(body)
        rescue JSON::ParserError
          body
        end

        def build_error(bool_error)
          if bool_error
            if @body.has_key?('error')
              {
                code: @body['error']['code'],
                message: @body['error']['message']
              }
            else
              {
                code: @body['code'],
                message: @body['message']
              }
            end
          else
            nil
          end
        end

    end
  end
end

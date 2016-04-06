module Jpush
  module Http
    class Response

      attr_accessor :http_code, :body, :heades

      def initialize(http_code, body)
        @http_code = http_code.to_i
        @body = parse_body(body)
      end

      private

        def parse_body(body)
          body = JSON.parse(body)
        rescue JSON::ParserError
          body
        end

    end
  end
end

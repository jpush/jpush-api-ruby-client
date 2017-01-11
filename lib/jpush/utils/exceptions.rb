module JPush
  module Utils
    module Exceptions

      class JPushError < StandardError
        attr_reader :message
        def initialize(message)
          @message = message
        end
      end

      class JPushArgumentError < JPushError
      end

      class JPushResponseError < JPushError
        attr_reader :http_code, :error_code, :error_message

        def initialize(http_code, error_code, error_message)
          @http_code, @error_code, @error_message = http_code, error_code, error_message
          @error_message = "UnknownError[#{@http_code}]." if @error_message.nil?
          super("#{@error_message} (error code: #{@error_code}) ")
        end

        def to_s
          "#{@message}. http status code: #{@http_code}"
        end
      end

      class TimeOutError < JPushError
        def initialize(error)
          super("#{error.class} was raised, please rescue it")
        end
      end

    end
  end
end

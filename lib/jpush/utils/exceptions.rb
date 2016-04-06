require 'jpush/utils/helper'

module Jpush
  module Utils
    module Exceptions
      using Utils::Helper::ObjectExtensions

      class JpushError < StandardError
        attr_reader :message
        def initialize(message)
          @message = message
        end
      end

      class JpushArgumentError < JpushError
      end

      class MissingArgumentError < JpushArgumentError
        def initialize(missed_args)
          list = missed_args.map {|arg| arg.to_s} * (', ')
          msg = "#{list} are required."
          super(msg)
        end
      end

      class InvalidArgumentError < JpushArgumentError
        def initialize(invalid_args, msg = nil)
          list = invalid_args.map {|arg| arg.to_s} * (', ')
          msg ||= "#{list} can not be blank."
          super(msg)
        end
      end

      class InvalidWordError < JpushError
        def initialize(name, word)
          super("invalid #{name}: #{word} ( #{name} can only contain letters, numbers, '_' and Chinese character)")
        end
      end

      class InvalidElementError < JpushError
        def initialize(name, invalid_element, list)
          super("invalid #{name}: #{invalid_element} ( #{name} only support #{list * (', ')}")
        end
      end

      class OverLimitError < JpushError
        def initialize(name, limit, unit)
          super("#{name} must have at most #{limit} #{unit}")
        end
      end

      class JpushResponseError < JpushError
        attr_reader :http_code, :error_code, :error_message

        def initialize(response)
          @http_code = response.code
          body = JSON.parse(response.body)
          @error_code, @error_message =
            if body.has_key?('error')
              [body['error']['code'], body['error']['message']]
            else
              [body['code'], body['message']]
            end
          @error_message = "UnknownError[#{@http_code}]." if @error_message.blank?
          super("Request Failed: #{@error_message}")
        end

        def to_s
          "#{@message}. error code: #{@error_code}, http status code: #{@http_code}"
        end

      end

    end
  end
end

require 'jpush/utils/helper'

module JPush
  module Utils
    module Exceptions
      using Utils::Helper::ObjectExtensions

      class JPushError < StandardError
        attr_reader :message
        def initialize(message)
          @message = message
        end
      end

      class JPushArgumentError < JPushError
      end

      class MissingArgumentError < JPushArgumentError
        def initialize(missed_args)
          list = missed_args.map {|arg| arg.to_s} * (', ')
          msg = "#{list} are required."
          super(msg)
        end
      end

      class InvalidArgumentError < JPushArgumentError
        def initialize(invalid_args, msg = nil)
          list = invalid_args.map {|arg| arg.to_s} * (', ')
          msg ||= "#{list} can not be blank."
          super(msg)
        end
      end

      class InvalidWordError < JPushError
        def initialize(name, word)
          super("invalid #{name}: #{word} ( #{name} can only contain letters, numbers, '_' and Chinese character)")
        end
      end

      class InvalidElementError < JPushError
        def initialize(name, invalid_element, list)
          super("invalid #{name}: #{invalid_element} ( #{name} only support #{list * (', ')} )")
        end
      end

      class OverLimitError < JPushError
        def initialize(name, limit, unit)
          super("#{name} must have at most #{limit} #{unit}")
        end
      end

      class JPushResponseError < JPushError
        attr_reader :http_code, :error_code, :error_message

        def initialize(http_code, error_code, error_message)
          @http_code, @error_code, @error_message = http_code, error_code, error_message
          @error_message = "UnknownError[#{@http_code}]." if @error_message.blank?
          super("#{@error_message} (error code: #{@error_code}) ")
        end

        def to_s
          "#{@message}. http status code: #{@http_code}"
        end
      end

      class VIPAppKeyError < JPushResponseError
        def initialize(http_code, error_code, error_message)
          super(http_code, error_code, error_message)
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

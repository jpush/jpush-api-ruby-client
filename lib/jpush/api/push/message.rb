require 'jpush/api/helper/argument_helper'

module Jpush
  module Api
    module Push
      class Message
        extend Helper::ArgumentHelper

        def initialize(msg_content: , title: nil, content_type: nil, extras: nil)
          check_argument({title: title, content_type: content_type}, extras)
          Message.ensure_argument_type('extras', extras, Hash) unless extras.nil?
          @msg_content, @title, @content_type, @extras = msg_content, title, content_type, extras
        end

        def build
          @message = {
            msg_content: @msg_content,
            title: @title,
            content_type: @content_type,
            extras: @extras
          }.reject{|key, value| value.nil?}
          self
        end

        def to_hash
          @message
        end

        private
          def check_argument(args, extras)
            args.each do |key, value|
              Message.ensure_argument_not_blank(key, value) unless value.nil?
            end
            unless extras.nil?
              Message.ensure_argument_not_blank('extras', extras)
              Message.ensure_argument_type('extras', extras, Hash)
            end
          end
      end
    end
  end
end

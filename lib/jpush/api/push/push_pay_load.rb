require 'jpush/api/helper/argument_helper'
require 'jpush/api/push/audience'
require 'jpush/api/push/notification'
require 'jpush/api/push/message'

module Jpush
  module Api
    module Push
      class PushPayload
        extend Helper::ArgumentHelper

        attr_reader :platform, :audience, :notification, :message

        VALID_PLATFORM = ['android', 'ios']

        def initialize(platform: , audience: , notification: nil, message: nil)
          @platform = build_platform(platform)
          @audience = build_audience(audience)
          @notification = build_notification(notification) unless notification.nil?
          @message = build_message(message) unless message.nil?
        end

        def add_sms_message(msg)
          @sms = build_sms_message(msg)
        end

        def add_options(opts)
          @options = build_options(opts)
        end

        def build
          ensure_content
          self
        end

        private

          def build_platform(platform)
            PushPayload.ensure_argument_not_blank('platform', platform)
            return VALID_PLATFORM if 'all' == platform

            platform.each do |pf|
              raise ArgumentError, "Invalid Platform #{pf.upcase}" unless VALID_PLATFORM.include?(pf)
            end
            platform
          end

          def build_audience(audience)
            PushPayload.ensure_argument_not_blank('audience', audience)
            return 'all' if 'all' == audience.downcase
            PushPayload.ensure_argument_type('audience', audience, Audience)
            audience
          end

          def build_notification(notification)
            PushPayload.ensure_argument_not_blank('notification', notification)
            return {alert: notification} if notification.is_a?(String)
            PushPayload.ensure_argument_type('notification', notification, Notification)
            notification
          end

          def build_message(message)
            PushPayload.ensure_argument_not_blank('message', message)
            return Message.new(msg_content: message).build if message.is_a?(String)
            PushPayload.ensure_argument_type('message', message, Message)
            message
          end

          def build_sms_message(msg)
          end

          def build_options(opts)
          end

          def ensure_content
            raise ArgumentError, 'No Notification OR Message Found' unless @notification || @message
          end

      end
    end
  end
end

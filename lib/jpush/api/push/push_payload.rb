require 'jpush/api/helper/argument_helper'
require 'jpush/api/push/audience'
require 'jpush/api/push/notification'

module Jpush
  module Api
    module Push
      class PushPayload
        extend Helper::ArgumentHelper
        using Utils::Helper::ObjectExtensions

        attr_reader :platform, :audience, :notification, :message, :sms_message, :options

        VALID_PLATFORM = ['android', 'ios']
        VALID_OPTION_KEY = [:sendno, :time_to_live, :override_msg_id, :apns_production, :big_push_duration]
        MAX_SMS_CONTENT_SIZE = 480
        MAX_SMS_DELAY_TIME = 86400    # 24 * 60 * 60 (second)

        def initialize(platform: , audience: , notification: nil, message: nil)
          @platform = 'all' == platform ? VALID_PLATFORM : build_platform(platform)
          @audience = 'all' == audience ? 'all' : build_audience(audience)
          @notification = build_notification(notification) unless notification.nil?
          @message = build_message(message) unless message.nil?
        end

        def set_message(msg_content, title: nil, content_type: nil, extras: nil)
          @message = build_message(msg_content, title, content_type, extras)
          self
        end

        def add_sms_message(content, delay_time = 0)
          @sms_message = build_sms_message(content, delay_time)
          self
        end

        def add_options(opts)
          @options = build_options(opts)
          self
        end

        def build
          ensure_content_available
          @push_payload =  {
            platform: @platform,
            audience: @audience,
            notification: @notification,
            message: @message,
            sms_message: @sms_message,
            options: @options
          }.compact
          self
        end

        def to_hash
          @push_payload
        end

        private

          def build_platform(platform)
            PushPayload.ensure_argument_not_blank('platform', platform)

            platform = [platform].flatten
            platform.each do |pf|
              raise ArgumentError, "Invalid Platform #{pf.upcase}" unless VALID_PLATFORM.include?(pf)
            end
            platform
          end

          def build_audience(audience)
            PushPayload.ensure_argument_not_blank('audience', audience)
            audience = audience.is_a?(Audience) ? audience : nil
            audience.to_hash
          end

          def build_notification(notification)
            PushPayload.ensure_argument_not_blank('notification', notification)
            return {alert: notification} if notification.is_a?(String)
            notification = notification.is_a?(Notification) ? notification : nil
            notification.to_hash
          end

          def build_message(msg_content, title = nil, content_type = nil, extras = nil)
            PushPayload.ensure_argument_not_blank('msg_content', msg_content)
            PushPayload.ensure_argument_not_blank('title', title) unless title.nil?
            PushPayload.ensure_argument_not_blank('content_type', content_type) unless content_type.nil?
            extras = nil if extras.nil? || !extras.is_a?(Hash) || extras.empty?
            message = {
              msg_content: msg_content,
              title: title,
              content_type: content_type,
              extras: extras
            }.compact
          end

          def build_sms_message(content, delay_time)
            PushPayload.ensure_argument_not_blank('content', content)
            PushPayload.ensure_string_not_over_size('content', content, MAX_SMS_CONTENT_SIZE)
            PushPayload.ensure_integer_not_over_size('delay_time', delay_time, MAX_SMS_DELAY_TIME)
            {content: content, delay_time: delay_time}
          end

          def build_options(opts)
            opts.each_key do |key|
              raise ArgumentError, "Invalid options item: #{key.upcase}" unless VALID_OPTION_KEY.include?(key.to_sym)
            end
          end

          def ensure_content_available
            raise ArgumentError, 'No Notification OR Message Found' unless @notification || @message
          end

      end
    end
  end
end

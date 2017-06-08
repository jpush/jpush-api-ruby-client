require 'jpush/push/audience'
require 'jpush/push/notification'

module JPush
  module Push
    class PushPayload

      MAX_SMS_CONTENT_SIZE = 480
      MAX_SMS_DELAY_TIME = 86400    # 24 * 60 * 60 (second)

      def initialize(platform: , audience: , notification: nil, message: nil)
        @platform = 'all' == platform ? 'all' : build_platform(platform)
        @audience = 'all' == audience ? 'all' : build_audience(audience)
        @notification = build_notification(notification) unless notification.nil?
        @message = build_message(message) unless message.nil?
      end

      def set_message(msg_content, title: nil, content_type: nil, extras: nil)
        @message = build_message(msg_content, title, content_type, extras)
        self
      end

      def set_sms_message(content, delay_time = 0)
        @sms_message = build_sms_message(content, delay_time)
        self
      end

      def set_options(opts)
        @options = opts
        self
      end

      def to_hash
        @push_payload =  {
          platform: @platform,
          audience: @audience,
          notification: @notification,
          message: @message,
          sms_message: @sms_message,
          options: { apns_production: false }.merge(@options.nil? ? {} : @options)
        }.select { |_, value| !value.nil? }
      end

      private

        def build_platform(platform)
          return platform if platform.is_a? Array
          return [platform]
        end

        def build_audience(audience)
          audience.is_a?(Audience) ? audience.to_hash : nil
        end

        def build_notification(notification)
          return {alert: notification} if notification.is_a?(String)
          notification.is_a?(Notification) ? notification.to_hash : nil
        end

        def build_message(msg_content, title = nil, content_type = nil, extras = nil)
          extras = (extras.nil? || !extras.is_a?(Hash) || extras.empty?) ? nil : extras
          message = {
            msg_content: msg_content,
            title: title,
            content_type: content_type,
            extras: extras
          }.select { |_, value| !value.nil? }
        end

        def build_sms_message(content, delay_time)
          delay_time = 0 if delay_time > MAX_SMS_DELAY_TIME
          {content: content, delay_time: delay_time}
        end

    end
  end
end

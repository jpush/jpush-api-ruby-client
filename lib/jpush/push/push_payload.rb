require 'jpush/helper/argument_helper'
require 'jpush/push/audience'
require 'jpush/push/notification'

module JPush
  module Push
    class PushPayload
      extend Helper::ArgumentHelper
      using Utils::Helper::ObjectExtensions

      VALID_OPTION_KEY = [:sendno, :time_to_live, :override_msg_id, :apns_production, :big_push_duration]
      MAX_SMS_CONTENT_SIZE = 480
      MAX_SMS_DELAY_TIME = 86400    # 24 * 60 * 60 (second)

      def initialize(platform: , audience: , notification: nil, message: nil)
        @platform = 'all' == platform ? JPush::Config.settings[:valid_platform] : build_platform(platform)
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
        @options = build_options(opts)
        self
      end

      def to_hash
        raise Utils::Exceptions::MissingArgumentError.new(['audience']) unless @audience
        err_msg = 'missing notification or message'
        raise Utils::Exceptions::JPushError, err_msg unless @notification || @message
        @push_payload =  {
          platform: @platform,
          audience: @audience,
          notification: @notification,
          message: @message,
          sms_message: @sms_message,
          options: @options
        }.compact
      end

      private

        def build_platform(platform)
          PushPayload.build_platform(platform)
        end

        def build_audience(audience)
          audience.is_a?(Audience) ? audience.to_hash : nil
        end

        def build_notification(notification)
          return {alert: notification} if notification.is_a?(String)
          notification.is_a?(Notification) ? notification.to_hash : nil
        end

        def build_message(msg_content, title = nil, content_type = nil, extras = nil)
          hash = {'msg_content': msg_content, 'title': title, 'content_type': content_type}.select{|key, value| !value.nil?}
          PushPayload.ensure_argument_not_blank(hash)
          extras = PushPayload.build_extras(extras)
          message = {
            msg_content: msg_content,
            title: title,
            content_type: content_type,
            extras: extras
          }.compact
        end

        def build_sms_message(content, delay_time)
          PushPayload.ensure_argument_not_blank('content': content)
          PushPayload.ensure_not_over_size('content', content, MAX_SMS_CONTENT_SIZE)
          delay_time = 0 if delay_time > MAX_SMS_DELAY_TIME
          {content: content, delay_time: delay_time}
        end

        def build_options(opts)
          opts.each_key do |key|
            raise Utils::Exceptions::InvalidElementError.new('options', key.to_sym, VALID_OPTION_KEY) unless VALID_OPTION_KEY.include?(key.to_sym)
          end
        end

    end
  end
end

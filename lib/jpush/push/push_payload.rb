require 'jpush/push/audience'
require 'jpush/push/notification'

module JPush
  module Push
    class PushPayload

      attr_reader :cid

      def initialize(platform: , audience: , notification: nil, message: nil, callback: nil, notification_3rd: nil)
        @platform = 'all' == platform ? 'all' : build_platform(platform)
        @audience = 'all' == audience ? 'all' : build_audience(audience)
        @notification = build_notification(notification) unless notification.nil?
        @message = build_message(message) unless message.nil?
        @callback = build_callback(callback) unless callback.nil?
        @notification_3rd = build_notification_3rd unless notification_3rd.nil?
      end

      def set_message(msg_content, title: nil, content_type: nil, extras: nil)
        @message = build_message(msg_content, title, content_type, extras)
        self
      end

      def set_callback(url: nil, params: nil, type: nil)
        @callback = build_callback(url, params, type)
        self
      end

      def set_notification_3rd(content, title: nil, channel_id: nil, uri_activity: nil, uri_action: nil, badge_add_num: nil, badge_class: nil, sound: nil, extras: nil)
        @notification_3rd = build_notification_3rd(content, title, channel_id, uri_activity, uri_action, badge_add_num, badge_class, sound, extras)
        self
      end

      def set_sms_message(sms_message)
        @sms_message = sms_message
        self
      end

      def set_options(options)
        @options = options
        self
      end

      def set_cid(cid)
        @cid= cid
        self
      end

      def to_hash
        @push_payload = {
          platform: @platform,
          audience: @audience,
          notification: @notification,
          message: @message,
          sms_message: @sms_message,
          options: { apns_production: false }.merge(@options.nil? ? {} : @options),
          cid: @cid
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

        def build_callback(url = nil, params = nil, type = nil)
          params = (params.nil? || !params.is_a?(Hash) || params.empty?) ? nil : params
          callback = {
            url: url,
            params: params,
            type: type
          }.select { |_, value| !value.nil? }
        end

        def build_notification_3rd(content, title: nil, channel_id: nil, uri_activity: nil, uri_action: nil, badge_add_num: nil, badge_class: nil, sound: nil, extras: nil)
          extras = (extras.nil? || !extras.is_a?(Hash) || extras.empty?) ? nil : extras
          callback = {
            content: content,
            title: title,
            channel_id: channel_id,
            uri_activity: uri_activity,
            uri_action: uri_action,
            badge_add_num: badge_add_num,
            badge_class: badge_class,
            sound: sound,
            extras: extras
          }.select { |_, value| !value.nil? }
        end

    end
  end
end

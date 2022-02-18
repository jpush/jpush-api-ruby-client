require 'jpush/push/notification'

module JPush
  module Push
    class SinglePushPayload

      def initialize(platform: , target: )
        @platform = 'all' == platform ? 'all' : build_platform(platform)
        @target = target
      end

      def set_notification(notification)
        @notification = notification
        self
      end

      def set_message(message)
        @message = message
        self
      end

      def set_callback(callback)
        @callback = callback
        self
      end

      def set_notification_3rd(notification_3rd)
        @notification_3rd = notification_3rd
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

      def to_hash
        single_push_payload = {
          platform: @platform,
          target: @target,
          notification: @notification,
          message: @message,
          sms_message: @sms_message,
          options: @options
          callback: @callback
          notification_3rd: @notification_3rd
        }.select { |_, value| !value.nil? }
      end

      private

        def build_platform(platform)
          return platform if platform.is_a? Array
          return [platform]
        end

    end
  end
end

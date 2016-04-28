require 'jpush/helper/argument_helper'

module JPush
  module Push
    class Notification
      extend Helper::ArgumentHelper
      using Utils::Helper::ObjectExtensions

      MAX_IOS_NOTIFICATION_SIZE = 2000

      def set_alert(alert)
        Notification.ensure_argument_not_blank('alert': alert)
        @alert = alert
        self
      end

      def set_not_alert
        @alert = ''
        self
      end

      def set_android(alert: , title: nil, builder_id: nil, extras: nil)
        extras = Notification.build_extras(extras)
        check_argument(alert: alert, title: title, builder_id: builder_id)
        @android = {
          alert: alert,
          title: title,
          builder_id: builder_id,
          extras: extras
        }.compact
        self
      end

      def set_ios(alert: , sound: nil, badge: nil, available: nil, category:nil, extras: nil)
        extras = Notification.build_extras(extras)
        badge = 0 == badge.to_i ? '0' : badge unless badge.nil?
        available = nil unless available.is_a? TrueClass
        check_argument(alert: alert, sound: sound, badge: badge, category: category)
        @ios = {
          alert: alert,
          sound: sound,
          badge: badge,
          'content-available': available,
          category: category,
          extras: extras
        }.compact
        Notification.ensure_not_over_bytesize('ios', {'ios': @ios}, MAX_IOS_NOTIFICATION_SIZE)
        self
      end

      def to_hash
        @notification = {
          alert: @alert,
          android: @android,
          ios: @ios
        }.compact
        raise Utils::Exceptions::JPushError, 'Notification can not be empty.' if @notification.empty?
        @notification
      end

      private

        def check_argument(args)
          hash = args.select{|key, value| !value.nil?}
          hash.delete(:alert) if '' == hash[:alert]
          Notification.ensure_argument_not_blank(hash)
        end

    end
  end
end

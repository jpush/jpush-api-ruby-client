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

      def set_android(alert: , title: nil, builder_id: nil,
        priority: nil, category: nil, style: nil, big_text: nil, inbox: nil, big_pic_path: nil, extras: nil)
        extras = Notification.build_extras(extras)
        @android = {
          alert: alert,
          title: title,
          builder_id: builder_id,
          priority: priority,
          category: category,
          style: style,
          big_text: big_text,
          inbox: inbox,
          big_pic_path: big_pic_path,
          extras: extras
        }.compact
        self
      end

      def set_ios(alert: , sound: nil, badge: '+1', available: nil, category:nil, extras: nil, contentavailable: nil, mutablecontent: nil)
        contentavailable = available if contentavailable.nil?
        extras = Notification.build_extras(extras)
        contentavailable = nil unless contentavailable.is_a? TrueClass
        mutablecontent = nil unless mutablecontent.is_a? TrueClass
        @ios = {
          alert: alert,
          sound: sound,
          badge: badge,
          'content-available': contentavailable,
          'mutable-content': mutablecontent,
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

    end
  end
end

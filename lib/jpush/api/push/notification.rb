require 'jpush/api/helper/argument_helper'

module Jpush
  module Api
    module Push
      class Notification
        extend Helper::ArgumentHelper

        MAX_IOS_NOTIFICATION_SIZE = 2000

        def set_alert(alert)
          Notification.ensure_argument_not_blank('alert', alert) unless '' == alert
          @alert = alert
          self
        end

        def set_android(alert: , title: nil, builder_id: nil, extras: nil)
          check_argument(alert, {title: title, builder_id: builder_id}, extras)
          @android = {
            alert: alert,
            title: title,
            builder_id: builder_id,
            extras: extras
          }.reject{|key, value| value.nil?}
          self
        end

        def set_ios(alert: , sound: nil, badge: nil, available: nil, category:nil, extras: nil)
          check_argument(alert, {sound: sound, badge: badge, category: category}, extras)
          Notification.ensure_string_can_convert_to_fixnum('badge', badge) unless badge.nil?
          Notification.ensure_argument_type('available', available, TrueClass) unless available.nil?
          @ios = {
            alert: alert,
            sound: sound,
            badge: badge,
            'content-available': available,
            category: category,
            extras: extras
          }.reject{|key, value| value.nil?}
          Notification.ensure_hash_not_over_bytesize('ios', {'ios': @ios}, MAX_IOS_NOTIFICATION_SIZE)
          self
        end

        def build
          @notification = {
            alert: @alert,
            android: @android,
            ios: @ios
          }.reject{|key, value| value.nil?}
          Notification.ensure_argument_not_blank('notification', @notification)
          self
        end

        def to_hash
          @notification
        end

        private

          def check_argument(alert, args, extras = nil)
            Notification.ensure_argument_not_blank('alert', alert) unless '' == alert
            args.each do |key, value|
              Notification.ensure_argument_not_blank(key, value) unless value.nil?
            end
            unless extras.nil?
              Notification.ensure_argument_not_blank('extras', extras)
              Notification.ensure_argument_type('extras', extras, Hash)
            end
          end

      end
    end
  end
end

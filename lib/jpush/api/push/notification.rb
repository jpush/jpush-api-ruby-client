require 'jpush/api/helper/argument_helper'

module Jpush
  module Api
    module Push
      class Notification
        extend Helper::ArgumentHelper

        MAX_IOS_NOTIFICATION_SIZE = 2000

        def set_alert(alert)
          Notification.ensure_argument_not_blank('alert', alert)
          @alert = alert
          self
        end

        def set_not_alert
          @alert = ''
          self
        end

        def set_android(alert: , title: nil, builder_id: nil, extras: nil)
          extras = nil if extras.nil? || !extras.is_a?(Hash) || extras.empty?
          check_argument(alert, {title: title, builder_id: builder_id})
          @android = {
            alert: alert,
            title: title,
            builder_id: builder_id,
            extras: extras
          }.reject{|key, value| value.nil?}
          self
        end

        def set_ios(alert: , sound: nil, badge: nil, available: nil, category:nil, extras: nil)
          extras = nil if extras.nil? || !extras.is_a?(Hash) || extras.empty?
          check_argument(alert, {sound: sound, badge: badge, category: category})
          badge = 0 == badge.to_i ? '0' : badge unless badge.nil?
          available = nil unless available.is_a? TrueClass
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

          def check_argument(alert, args)
            Notification.ensure_argument_not_blank('alert', alert) unless '' == alert
            args.each do |key, value|
              Notification.ensure_argument_not_blank(key, value) unless value.nil?
            end
          end

      end
    end
  end
end

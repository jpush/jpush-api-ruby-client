require 'test_helper'

module Jpush
  module Api
    module Push
      class NotificationTest < Jpush::Test

        def setup
          @notification = Notification.new
        end

        def test_new_notification
          assert_raises ArgumentError do
            @notification.build
          end
        end

        def test_set_alert
          result = @notification.set_alert('jpush').build.to_hash
          assert_equal 1, result.size
          assert_true result.has_key?(:alert)
          assert_true result[:alert].include?('jpush')
        end

        def test_alert_sets
          result = @notification.
            set_alert('Hello Jpush').
            set_android(alert: 'Hello Android').
            set_ios(alert: 'Hello IOS').
            build.to_hash
          assert_equal 3, result.size
          assert_true result.has_key?(:alert)
          assert_true result.has_key?(:android)
          assert_true result.has_key?(:ios)
        end

        def test_sets
          result = @notification.
            set_alert('Hello Jpush').
            set_android(
              alert: 'Hello Android',
              title: 'hello',
              extras: {
                key0: 'value0',
                key1: 'value1'
              }
            ).set_ios(
              alert: 'Hello IOS',
              sound: 'sound',
              badge: '+1',
              available: true,
              category: 'jpush',
              extras: {
                key2: 'value2',
                key3: 'value3'
              }
            ).build.to_hash
          assert_equal 3, result.size
          assert_true result.has_key?(:alert)
          assert_true result.has_key?(:android)
          assert_true result.has_key?(:ios)

          assert_equal 3, result[:android].length
          assert_equal 6, result[:ios].length
        end

      end
    end
  end
end

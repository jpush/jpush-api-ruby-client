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
          result = @notification.set_alert('').build
          assert_equal 1, result.size
          assert_true result.has_key?(:alert)
          assert_true result[:alert].include?('')

          result = @notification.set_alert('jpush').build
          assert_equal 1, result.size
          assert_true result.has_key?(:alert)
          assert_true result[:alert].include?('jpush')
        end

        def test_alert_sets
          result = @notification.
            set_alert('Hello Jpush').
            set_android(alert: 'Hello Android').
            set_ios(alert: 'Hello IOS').
            build
          assert_equal 3, result.size
          assert_true result.has_key?(:alert)
          assert_true result.has_key?(:android)
          assert_true result.has_key?(:ios)
        end

      end
    end
  end
end

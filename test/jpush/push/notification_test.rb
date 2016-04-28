require 'test_helper'

module JPush
  module Push
    class NotificationTest < JPush::Test

      def setup
        @notification = Notification.new
      end

      def test_new_notification
        assert_raises Utils::Exceptions::JPushError do
          @notification.to_hash
        end
      end

      def test_set_alert
        result = @notification.set_alert('jpush').to_hash
        assert_equal 1, result.size
        assert_true result.has_key?(:alert)
        assert_true result[:alert].include?('jpush')
      end

      def test_alert_sets
        result = @notification.
          set_alert('Hello JPush').
          set_android(alert: 'Hello Android').
          set_ios(alert: 'Hello IOS').to_hash
        assert_equal 3, result.size
        assert_true result.has_key?(:alert)
        assert_true result.has_key?(:android)
        assert_true result.has_key?(:ios)
      end

      def test_sets
        result = @notification.
          set_alert('Hello JPush').
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
          ).to_hash
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

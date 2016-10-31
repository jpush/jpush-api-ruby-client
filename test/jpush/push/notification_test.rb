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

        result = @notification.
          set_alert('Hello JPush').
          set_android(alert: 'Hello Android').
          set_ios(alert: { k1: 'v1', k2: 'v2' }).to_hash
        assert_equal 3, result.size
        assert_true result[:ios][:alert].is_a? Hash
        assert_equal 2, result[:ios][:alert].size
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
            contentavailable: true,
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

      def test_content_available
        result = @notification.
          set_alert('Hello JPush').
          set_ios(
            alert: { k1: 'v1', k2: 'v2' },
            available: true
          ).to_hash
        assert_equal 2, result[:ios].size
        assert_true result[:ios][:'content-available'].is_a? TrueClass

        result = @notification.
          set_alert('Hello JPush').
          set_ios(
            alert: { k1: 'v1', k2: 'v2' },
            contentavailable: true
          ).to_hash
        assert_equal 2, result[:ios].size
        assert_true result[:ios][:'content-available'].is_a? TrueClass

        result = @notification.
          set_alert('Hello JPush').
          set_ios(
            alert: { k1: 'v1', k2: 'v2' },
            available: true,
            contentavailable: false
          ).to_hash
        assert_equal 1, result[:ios].size
        assert_true result[:ios][:'content-available'].nil?

        result = @notification.
          set_alert('Hello JPush').
          set_ios(
            alert: { k1: 'v1', k2: 'v2' },
            available: false,
            contentavailable: true
          ).to_hash
        assert_equal 2, result[:ios].size
        assert_true result[:ios][:'content-available'].is_a? TrueClass
      end

      def test_available
        result = @notification.
          set_alert('Hello JPush').
          set_ios(
            alert: { k1: 'v1', k2: 'v2' },
            contentavailable: true,
            mutableavailable: true
          ).to_hash
        assert_equal 3, result[:ios].size
        assert_true result[:ios][:'content-available'].is_a? TrueClass
        assert_true result[:ios][:'mutable-available'].is_a? TrueClass
      end

    end
  end
end

require_relative '../../test_helper'

module JPush
  module Push
    class SinglePushPayloadTest < JPush::Test

      def setup
        @hello_payload = SinglePushPayload.new(platform: 'all', target: 'hello')
      end

      def test_platform_and_target
        single_push_payload = SinglePushPayload.new(
          platform: 'android',
          target: 'hello'
        ).to_hash
        assert_true single_push_payload[:platform].include?('android')
        assert_true single_push_payload[:target].include?('hello')
      end

      def test_field
        notification = {
          alert: 'Hello world',
          android: {
            title: 'welcome',
            alert: 'welcome android'
          }
        }
        @hello_payload.set_notification(notification)
        payload_hash = @hello_payload.to_hash
        assert_true payload_hash[:notification].has_key?(:alert)
        assert_equal 'welcome android', payload_hash[:notification][:android][:alert]
      end

    end
  end
end

require 'test_helper'

module JPush
  module Push
    class PushPayloadTest < JPush::Test

      def setup
        @hello_payload = PushPayload.new(platform: 'all', audience: 'all', notification: 'hello')
      end

      def test_platform
        push_payload = PushPayload.new(
          platform: 'android',
          audience: 'all',
          notification: 'hello'
        ).to_hash
        assert_true push_payload[:platform].include?('android')
      end

      def test_audience
        push_payload = PushPayload.new(
          platform: 'all',
          audience: Audience.new.set_tag('jpush'),
          notification: 'hello'
        ).to_hash
        assert_true push_payload[:audience].has_key?(:tag)
        assert_true push_payload[:audience][:tag].include?('jpush')
      end

      def test_notification
        push_payload = PushPayload.new(
          platform: 'all',
          audience: 'all',
          notification: 'hello'
        ).to_hash
        assert_true push_payload[:notification].has_key?(:alert)
        assert_equal 'hello', push_payload[:notification][:alert]
      end

      def test_message
        assert_false @hello_payload.to_hash.has_key?(:message)
        push_payload = @hello_payload.set_message('hello jpush').to_hash
        assert_true push_payload.has_key?(:message)

        message = push_payload[:message]
        assert_equal 1, message.size
        assert_true message.has_key?(:msg_content)
        assert_true message[:msg_content].include?('hello jpush')

        push_payload = @hello_payload.set_message(
          'hello jpush',
          title: 'hello title',
          content_type: 'text',
          extras: {key0: 'value0', key1: 'value1'}
        ).to_hash
        message = push_payload[:message]
        assert_instance_of Hash, message
        assert_equal 4, message.size
      end

      def test_sms
        assert_false @hello_payload.to_hash.has_key?(:sms_message)
        push_payload = @hello_payload.set_sms_message('hello jpush', 100).to_hash
        assert_true push_payload.has_key?(:sms_message)

        sms = push_payload[:sms_message]
        assert_true sms.has_key?(:content)
        assert_true sms.has_key?(:delay_time)
        assert_equal 'hello jpush', sms[:content]
      end

      def test_options
        opts = @hello_payload.set_options(sendno: '000').to_hash[:options]
        assert_true opts.has_key?(:sendno)
        assert_true opts.has_key?(:apns_production)
        assert_equal 2, opts.size
        assert_equal '000', opts[:sendno]
      end

    end
  end
end

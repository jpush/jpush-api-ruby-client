require 'test_helper'

module JPush
  module Push
    class PushPayloadTest < JPush::Test

      def setup
        @hello_payload = PushPayload.new(platform: 'all', audience: 'all', notification: 'hello')
      end

      def test_initialize
        push_payload = PushPayload.new(platform: 'all', audience: 'all')

        assert_raises Utils::Exceptions::JPushError do
          push_payload.build
        end

        push_payload = PushPayload.new(
          platform: 'all',
          audience: 'all',
          notification: 'hello',
          message: 'jpush'
        )

        assert_instance_of(Array, push_payload.platform)
        assert_true push_payload.platform.include?('android')
        assert_true push_payload.platform.include?('ios')

        assert_instance_of(String, push_payload.audience)
        assert_equal 'all', push_payload.audience

        assert_instance_of(Hash, push_payload.notification)
        assert_equal 1, push_payload.notification.size
        assert_true push_payload.notification.has_key?(:alert)
        assert_equal 'hello', push_payload.notification[:alert]

        assert_instance_of(Hash, push_payload.message)
        assert_equal 1, push_payload.message.size
        assert_true push_payload.message.has_key?(:msg_content)
        assert_equal 'jpush', push_payload.message[:msg_content]

        hash = push_payload.build.to_hash
        assert_true hash.has_key?(:platform)
        assert_true hash.has_key?(:audience)
        assert_true hash.has_key?(:notification)
        assert_true hash.has_key?(:message)
      end

      def test_platform
        assert_raises Utils::Exceptions::InvalidElementError do
          PushPayload.new(platform: 'iPhone', audience: 'all', notification: 'hello').build
        end
        push_payload = PushPayload.new(platform: 'android', audience: 'all', notification: 'hello').build
        assert_true push_payload.platform.include?('android')
      end

      def test_audience
        push_payload = PushPayload.new(platform: 'all', audience: 'jpush', notification: 'hello')
        assert_raises Utils::Exceptions::MissingArgumentError do
          push_payload.build
        end
        push_payload = PushPayload.new(platform: 'all', audience: Audience.new.set_tag('jpush').build, notification: 'hello').build
        assert_true push_payload.audience.has_key?(:tag)
        assert_true push_payload.audience[:tag].include?('jpush')
      end

      def test_notification
        push_payload = PushPayload.new(platform: 'all', audience: 'all', notification: 'hello').build
        assert_true push_payload.notification.has_key?(:alert)
        assert_equal 'hello', push_payload.notification[:alert]
      end

      def test_message
        assert_false @hello_payload.build.to_hash.has_key?(:message)
        @hello_payload.set_message('hello jpush')
        assert_true @hello_payload.build.to_hash.has_key?(:message)

        message = @hello_payload.message
        assert_equal 1, message.size
        assert_true message.has_key?(:msg_content)
        assert_true message[:msg_content].include?('hello jpush')

        @hello_payload.set_message(
          'hello jpush',
          title: 'hello title',
          content_type: 'text',
          extras: {key0: 'value0', key1: 'value1'}
        )
        message = @hello_payload.message
        assert_instance_of Hash, message
        assert_equal 4, message.size
        assert_true message.has_key?(:msg_content)
        assert_true message.has_key?(:title)
        assert_true message.has_key?(:content_type)
        assert_true message.has_key?(:extras)
      end

      def test_sms
        assert_false @hello_payload.build.to_hash.has_key?(:sms_message)
        @hello_payload.set_sms_message('hello jpush', 100)
        assert_true @hello_payload.build.to_hash.has_key?(:sms_message)

        sms = @hello_payload.sms_message
        assert_true sms.has_key?(:content)
        assert_true sms.has_key?(:delay_time)
        assert_equal 'hello jpush', sms[:content]
      end

      def test_options
        assert_raises Utils::Exceptions::InvalidElementError do
          @hello_payload.set_options(key1: 'value1', key2: 'value2')
        end
        @hello_payload.set_options(sendno: '000').build
        opts = @hello_payload.options
        assert_true opts.has_key?(:sendno)
        assert_equal 1, opts.size
        assert_equal '000', opts[:sendno]
      end

    end
  end
end

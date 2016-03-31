require 'test_helper'

module Jpush
  module Api
    module Push
      class PushPayloadTest < Jpush::Test

        def setup
          @hello_payload = PushPayload.new(platform: 'all', audience: 'all', notification: 'hello')
        end

        def test_initialize
          push_payload = PushPayload.new(platform: 'all', audience: 'all')

          assert_raises ArgumentError do
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
          @hello_payload.add_sms_message('hello jpush', 100)
          assert_true @hello_payload.build.to_hash.has_key?(:sms_message)

          sms = @hello_payload.sms_message
          assert_true sms.has_key?(:content)
          assert_true sms.has_key?(:delay_time)
          assert_equal 'hello jpush', sms[:content]

        end

      end
    end
  end
end

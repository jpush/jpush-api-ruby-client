require 'test_helper'

module Jpush
  module Api
    module Push
      class PushPayLoadTest < Jpush::Test

        def test_new
          push = PushPayload.new(platform: 'all', audience: 'all')

          assert_raises ArgumentError do
            push.build
          end

          PushPayload.new(platform: 'all', audience: 'all', notification: 'hello').build
          PushPayload.new(platform: 'all', audience: 'all', message: 'jpush').build

          push = PushPayload.new(
            platform: 'all',
            audience: 'all',
            notification: 'hello',
            message: 'jpush'
          ).build

          assert_instance_of(Array, push.platform)
          assert_true push.platform.include?('android')
          assert_true push.platform.include?('ios')

          assert_instance_of(String, push.audience)
          assert_equal 'all', push.audience

          assert_instance_of(Hash, push.notification)
          assert_equal 1, push.notification.size
          assert_true push.notification.has_key?(:alert)
          assert_equal 'hello', push.notification[:alert]

          assert_instance_of(Hash, push.message)
          assert_equal 1, push.message.size
          assert_true push.message.has_key?(:msg_content)
          assert_equal 'jpush', push.message[:msg_content]
        end

      end
    end
  end
end

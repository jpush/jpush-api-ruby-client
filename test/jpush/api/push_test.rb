require 'test_helper'

module Jpush
  module Api
    class PushTest < Jpush::Test

      def setup
        @pusher = @@jPush.pusher
        @all_push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello jpush from push api').build
      end

      def test_validate
        response = @pusher.validate(@all_push_payload)
        assert_equal 200, response.http_code
        body = response.body

        assert_true body.has_key?('sendno')
        assert_true body.has_key?('msg_id')
      end

      def test_simple_push_all
        response = @pusher.push(@all_push_payload)
        assert_equal 200, response.http_code
        body = response.body

        assert_true body.has_key?('sendno')
        assert_true body.has_key?('msg_id')
      end

      def test_push_full
        extras = {key0: 'value0', key1: 'value1'}
        notification = Push::Notification.new.set_android(alert: 'hello', title: 'android', extras: extras).build
        push_payload = Push::PushPayload.new(platform: 'android', audience: 'all', notification: notification).build
        response = @pusher.push(push_payload)
        assert_equal 200, response.http_code
        assert_true response.body.has_key?('msg_id')
      end

    end
  end
end

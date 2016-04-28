require 'test_helper'

module JPush
  class PushTest < JPush::Test

    def setup
      @pusher = @@jpush.pusher
    end

    def test_validate
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api')
      response = @pusher.validate(push_payload)
      assert_equal 200, response.http_code
      body = response.body

      assert_true body.has_key?('sendno')
      assert_true body.has_key?('msg_id')
    end

    def test_simple_push_all
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api')
      response = @pusher.push(push_payload)
      assert_equal 200, response.http_code
      body = response.body

      assert_true body.has_key?('sendno')
      assert_true body.has_key?('msg_id')
    end

    def test_push_full
      extras = {key0: 'value0', key1: 'value1'}
      notification = Push::Notification.new.set_android(alert: 'hello', title: 'hello android', extras: extras)
      push_payload = Push::PushPayload.new(platform: 'android', audience: 'all', notification: notification)
      response = @pusher.push(push_payload)
      assert_equal 200, response.http_code
      assert_true response.body.has_key?('msg_id')

      # notification = Push::Notification.new.set_ios(alert: 'hello', extras: extras)
      # push_payload = Push::PushPayload.new(platform: 'ios', audience: 'all', notification: notification)
      # response = @pusher.push(push_payload)
      # puts response.body
      # assert_equal 200, response.http_code
      # assert_true response.body.has_key?('msg_id')
    end

  end
end

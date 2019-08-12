require_relative '../test_helper'

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
      audience = Push::Audience.new().set_segment('1234567890').set_abtest('A')
      extras = {key0: 'value0', key1: 'value1'}
      notification = Push::Notification.new.set_android(alert: 'hello', title: 'hello android', extras: extras, channel_id: 'chan', large_icon:'https://img.jiguang.cn/favicon.ico', intent: {url: 'intent:#Intent;component=com.jiguang.push/com.example.jpushdemo.SettingActivity;end'})
      push_payload = Push::PushPayload.new(platform: 'android', audience: audience, notification: notification)
      sms_message = {delay_time: 120, signid: 12445, temp_id: 2352, temp_para: {k: 'v'}, active_filter: false}
      push_payload.set_sms_message(sms_message)
      response = @pusher.push(push_payload)
      assert_equal 200, response.http_code
      assert_true response.body.has_key?('msg_id')

      notification = Push::Notification.new
        .set_alert('hello')
        .set_ios(alert: extras, extras: extras, thread: 'default')
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: notification)
      response = @pusher.push(push_payload)
      assert_equal 200, response.http_code
      assert_true response.body.has_key?('msg_id')
    end

    def test_push_batch_regid
      single_push_payload = Push::SinglePushPayload.new(platform: 'all', target: $test_common_rid)
      single_push_payload.set_notification('alert notification')
      response = @pusher.push_batch_regid([single_push_payload])
      assert_equal 200, response.http_code
    end

    def test_push_batch_alias
      single_push_payload = Push::SinglePushPayload.new(platform: 'all', target: $test_common_alias)
      single_push_payload.set_notification('alert notification')
      response = @pusher.push_batch_alias([single_push_payload])
      assert_equal 200, response.http_code
    end

  end
end

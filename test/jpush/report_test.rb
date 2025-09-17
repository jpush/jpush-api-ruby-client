require_relative '../test_helper'

module JPush
  class ReportTest < JPush::Test

    def setup
      pusher = @@jpush.pusher
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from report api')
      @msg_id = pusher.push(push_payload).body['msg_id']
      sleep $test_report_delay_time

      @reporter = @@jpush.reporter
    end

    def test_received
      @reporter.received(@msg_id)
      @reporter.received(@msg_id)
      sleep $test_report_delay_time

      response = @reporter.received(@msg_id)
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of(Array, body)
      assert_equal 1, body.size

      result = body.first
      assert_instance_of(Hash, result)
    end

    def test_received_detail
      @reporter.received_detail(@msg_id)
      @reporter.received_detail(@msg_id)
      sleep $test_report_delay_time

      response = @reporter.received_detail(@msg_id)
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of(Array, body)
      assert_equal 1, body.size

      result = body.first
      assert_instance_of(Hash, result)
    end

    def test_messages
      response = @reporter.messages(@msg_id)
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of(Array, body)
      assert_equal 1, body.size

      result = body.first
      assert_instance_of(Hash, result)
      assert_equal 4, result.size

      assert_instance_of Hash, result['android']
      assert_instance_of Hash, result['ios']
      # assert_instance_of Hash, result['hmos'] #旧接口没维护了，不支持hmos
      assert_instance_of Hash, result['winphone']
    end

    def test_messages_detail
      response = @reporter.messages_detail(@msg_id)
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of(Array, body)
      assert_equal 1, body.size

      result = body.first
      assert_instance_of(Hash, result)
      assert_equal 8, result.size

      assert_instance_of Hash, result['jpush']
      assert_instance_of Hash, result['android_pns']
      assert_instance_of Hash, result['ios']
      assert_instance_of Hash, result['hmos']
      assert_instance_of Hash, result['winphone']
    end

    def test_status_message
      regid = 'ee323rsdf'
      response = @reporter.status_message(msg_id: @msg_id, registration_ids: [regid])
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of(Hash, body)
      assert_equal 1, body.size
      assert_instance_of Hash, body[regid]
    end

    def test_users
      response = @reporter.users('day', Time.now - 60*60*24, 1)
      assert_equal 200, response.http_code

      body = response.body
      assert_instance_of Hash, body
      assert_equal 4, body.size
      assert_equal 'DAY', body['time_unit']
      assert_equal (Time.now - 60*60*24).strftime('%F'), body['start']
      assert_equal 1, body['duration']

      items = body['items']
      assert_instance_of Array, items
      assert_equal 1, items.size
      assert_true items.first.has_key?('time')

      start = Time.new(2016, 2, 20, 4)

      response = @reporter.users('month', start, 2)
      assert_equal 200, response.http_code
      body = response.body
      assert_equal 'MONTH', body['time_unit']
      assert_equal 2, body['duration']
      assert_equal 2, body['items'].size

      response = @reporter.users('hour', start, 40)
      assert_equal 200, response.http_code
      body = response.body
      assert_equal 'HOUR', body['time_unit']
      assert_equal 24, body['duration']
      assert_equal 20, body['items'].size
    end

  end
end

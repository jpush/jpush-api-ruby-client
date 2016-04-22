require 'test_helper'

module JPush
  module Api
    class ReportTest < JPush::Test

      def setup
        pusher = @@jpush.pusher
        push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from report api').build
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
        assert_equal 5, result.size
        assert_equal @msg_id.to_i, result['msg_id']
      end

      def test_messages
        response = @reporter.messages(@msg_id)
        assert_equal 200, response.http_code

        body = response.body
        assert_instance_of(Array, body)
        assert_equal 1, body.size

        result = body.first
        assert_instance_of(Hash, result)
        assert_equal @msg_id.to_i, result['msg_id']
        assert_equal 4, result.size

        assert_equal @msg_id.to_i, result['msg_id']
        assert_instance_of Hash, result['android']
        assert_instance_of Hash, result['ios']
        assert_instance_of Hash, result['winphone']
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
end

require 'test_helper'

module Jpush
  module Api
    class ReportTest < Jpush::Test

      def setup
        pusher = @@jPush.pusher
        push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from report api').build
        @msg_id = pusher.push(push_payload).body['msg_id']
        sleep $test_report_delay_time

        @reporter = @@jPush.reporter
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
        assert_true result.has_key?('android_received')
        assert_true result.has_key?('ios_msg_received')
        assert_true result.has_key?('ios_apns_sent')
        assert_true result.has_key?('wp_mpns_sent')
        assert_true result.has_key?('msg_id')
        assert_equal @msg_id, result['msg_id'].to_s
        assert_false result['android_received'].nil?
      end

    end
  end
end

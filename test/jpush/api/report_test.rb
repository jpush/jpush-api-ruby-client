require 'test_helper'

module Jpush
  module Api
    class ReportTest < Jpush::Test

      def setup
        pusher = @@jPush.pusher
        push_payload0 = Push::PushPayload.new(platform: 'all', audience: 'all', notification: '[0] hello jpush from report api').build
        push_payload1 = Push::PushPayload.new(platform: 'all', audience: 'all', notification: '[1] hello jpush from report api').build
        @msg_id0 = pusher.push(push_payload0).body['msg_id']
        @msg_id1 = pusher.push(push_payload1).body['msg_id']
        sleep $test_repoer_delay_time

        @reporter = @@jPush.reporter
      end

      def test_received
        response = @reporter.received(@msg_id0)
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
        assert_equal @msg_id0, result['msg_id'].to_s
        assert_false result['android_received'].nil?

        response = @reporter.received([@msg_id0, @msg_id1])
        assert_equal 200, response.http_code

        body = response.body
        assert_instance_of(Array, body)
        assert_equal 2, body.size
        result0, result1 = body
        assert_equal @msg_id0, result0['msg_id'].to_s
        assert_equal @msg_id1, result1['msg_id'].to_s
      end

    end
  end
end

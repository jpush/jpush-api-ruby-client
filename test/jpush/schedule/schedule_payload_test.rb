require_relative '../../test_helper'

module JPush
  module Schedule
    class SchedulePayloadTest < JPush::Test

      def setup
        @push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello')
      end

      def test_single
        schedule_payload = SchedulePayload.new('jpush', Time.now, @push_payload).to_hash
        assert_instance_of Hash, schedule_payload
        assert_equal 4, schedule_payload.size
        assert_instance_of TrueClass, schedule_payload[:enabled]
        assert_true schedule_payload.has_key?(:name)
        assert_true schedule_payload.has_key?(:trigger)
        assert_true schedule_payload[:trigger].has_key?(:single)
        assert_true schedule_payload.has_key?(:push)
      end

      def test_periodical
        trigger = Trigger.new.set_periodical(
          Time.new(2015, 4, 20),
          Time.new(2016, 4, 20),
          '13:20',
          'week',
          2,
          'WED'
        )

        schedule_payload = SchedulePayload.new('jpush', trigger, @push_payload).to_hash
        assert_instance_of Hash, schedule_payload
        assert_equal 4, schedule_payload.size
        assert_true schedule_payload.has_key?(:trigger)
        assert_true schedule_payload[:trigger].has_key?(:periodical)
      end

      def test_update
        schedule_payload = SchedulePayload.new('jpush', nil, nil, nil).to_update_hash
        assert_instance_of Hash, schedule_payload
        assert_equal 1, schedule_payload.size

        schedule_payload = SchedulePayload.new('jpush', Time.new('2020'), @push_payload, true).to_update_hash
        assert_instance_of Hash, schedule_payload
        assert_equal 4, schedule_payload.size
      end

    end
  end
end

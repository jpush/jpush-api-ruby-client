require 'test_helper'

module Jpush
  module Api
    module Schedule
      class SchedulePayloadTest < Jpush::Test

        def setup
          @push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello').build
        end

        def test_single
          result = SchedulePayload.new('jpush', Time.now, @push_payload).build.to_hash
          assert_instance_of Hash, result
          assert_equal 4, result.size
          assert_instance_of TrueClass, result[:enabled]
          assert_true result.has_key?(:name)
          assert_true result.has_key?(:trigger)
          assert_true result[:trigger].has_key?(:single)
          assert_true result.has_key?(:push)
        end

        def test_periodical
          trigger = Trigger.new.set_periodical(
            Time.new(2015, 4, 20),
            Time.new(2016, 4, 20),
            '13:20',
            'week',
            2,
            'WED'
          ).build

          result = SchedulePayload.new('jpush', trigger, @push_payload).build.to_hash
          assert_instance_of Hash, result
          assert_equal 4, result.size
          assert_true result.has_key?(:trigger)
          assert_true result[:trigger].has_key?(:periodical)
        end

        def test_update
          result = SchedulePayload.new('jpush', nil, nil, nil).build_update.to_hash
          assert_instance_of Hash, result
          assert_equal 1, result.size

          result = SchedulePayload.new('jpush', Time.new('2020'), @push_payload, true).build_update.to_hash
          assert_instance_of Hash, result
          assert_equal 4, result.size
        end

      end
    end
  end
end

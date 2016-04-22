require 'test_helper'

module JPush
  module Api
    module Schedule
      class TriggerTest < JPush::Test

        def setup
          @trigger = Trigger.new
        end

        def test_single
          result = @trigger.set_single(Time.now).build.to_hash
          assert_instance_of Hash, result
          assert_equal 1, result.size
          assert_instance_of Hash, result[:single]
          assert_equal 1, result[:single].size
        end

        def test_periodical
          result = @trigger.set_periodical(
            Time.new(2015, 4, 20),
            Time.new(2016, 4, 20),
            '13:20',
            'week',
            2,
            'WED'
          ).build.to_hash
          assert_instance_of Hash, result
          assert_equal 1, result.size
          assert_instance_of Hash, result[:periodical]
          assert_equal 6, result[:periodical].size
        end

      end
    end
  end
end

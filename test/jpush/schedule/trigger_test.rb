require_relative '../../test_helper'

module JPush
  module Schedule
    class TriggerTest < JPush::Test

      def setup
        @trigger = Trigger.new
      end

      def test_single
        trigger = @trigger.set_single(Time.now).to_hash
        assert_instance_of Hash, trigger
        assert_equal 1, trigger.size
        assert_instance_of Hash, trigger[:single]
        assert_equal 1, trigger[:single].size
      end

      def test_periodical
        trigger = @trigger.set_periodical(
          Time.new(2025, 4, 20),
          Time.new(2026, 4, 20),
          '13:20',
          'week',
          2,
          'WED'
        ).to_hash
        assert_instance_of Hash, trigger
        assert_equal 1, trigger.size
        assert_instance_of Hash, trigger[:periodical]
        assert_equal 6, trigger[:periodical].size
      end

    end
  end
end

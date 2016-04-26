require 'test_helper'

module JPush
  module Push
    class AudienceTest < JPush::Test

      def setup
        @audience = Audience.new
      end

      def test_new_audience
        assert_raises Utils::Exceptions::JPushError do
          @audience.build
        end
      end

      def test_set_tag
        result = @audience.set_tag('jpush').build.to_hash

        assert_equal 1, result.size
        assert_true result.has_key?(:tag)
        assert_true result[:tag].include?('jpush')
      end

      def test_sets
        result = @audience.
          set_tag(['jpush', 'j', 'p', 'u', 's', 'h']).
          set_tag_and('jpush').
          set_alias('jpush').
          set_registration_id('jpush').
          build.to_hash

        assert_equal 4, result.size
        assert_true result[:tag].include?('jpush')
        assert_true result[:tag_and].include?('jpush')
        assert_true result[:alias].include?('jpush')
        assert_true result[:registration_id].include?('jpush')

        assert_equal 6, result[:tag].size
      end

    end
  end
end

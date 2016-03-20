require 'test_helper'

module Jpush
  module Utils

    class ArgumentCheckTest < Jpush::Test

      def setup
        @klass = Class.new{ extend Utils::ArgumentCheck }
      end

      def test_check_registration_id
        assert_raises ArgumentError do
         @klass.check_registration_id('')
        end
        assert_raises ArgumentError do
         @klass.check_registration_id(' ')
        end
        assert_raises ArgumentError do
         @klass.check_registration_id(nil)
        end

        assert_nil @klass.check_registration_id('INVALID_REGISTRATION_ID')
      end

      def test_check_mobile
        assert_raises ArgumentError do
         @klass.check_mobile('')
        end
        assert_raises ArgumentError do
         @klass.check_mobile(' ')
        end
        assert_raises ArgumentError do
         @klass.check_mobile(nil)
        end
        assert_raises ArgumentError  do
         @klass.check_mobile('1' * 10)
        end

        assert_nil @klass.check_mobile('1' * 11)
      end

      def test_ensure_argument_not_nil
        assert_raises ArgumentError  do
          @klass.ensure_argument_not_nil('arg', nil)
        end
        assert_nil @klass.ensure_argument_not_nil('arg', ' ')
        assert_nil @klass.ensure_argument_not_nil('arg', [])
      end

    end
  end
end

require 'test_helper'

module Jpush
  module Api
    module Helper
      class ArgumentCheckTest < Jpush::Test

        def setup
          @klass = Class.new{ extend ArgumentCheck }
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
            @klass.check_mobile('1' * 11)
          end

          assert_nil @klass.check_mobile('13800138000')
        end

        def test_ensure_argument_not_blank
          assert_raises ArgumentError do
           @klass.ensure_argument_not_blank('arg', '')
          end
          assert_raises ArgumentError do
           @klass.ensure_argument_not_blank('arg', ' ')
          end
          assert_raises ArgumentError do
           @klass.ensure_argument_not_blank('arg', nil)
          end

          assert_nil @klass.ensure_argument_not_blank('arg', 'RANDOM_STRING')
          assert_nil @klass.ensure_argument_not_blank('arg', 'RANDOM STRING')
        end

        def test_ensure_argument_not_nil
          assert_raises ArgumentError  do
            @klass.ensure_argument_not_nil('arg', nil)
          end

          assert_nil @klass.ensure_argument_not_nil('arg', '')
          assert_nil @klass.ensure_argument_not_nil('arg', [])
        end

        def test_ensure_word_valid
          assert_raises ArgumentError do
            @klass.ensure_word_valid('arg', '')
          end
          assert_raises ArgumentError do
            @klass.ensure_word_valid('arg', 'jpush#000')
          end
          assert_raises ArgumentError do
            @klass.ensure_word_valid('arg', 'あいうえお')
          end
          assert_raises ArgumentError do
            @klass.ensure_word_valid('arg', 'jpush@')
          end

          assert_nil @klass.ensure_word_valid('arg', '极光推送')
          assert_nil @klass.ensure_word_valid('arg', 'jpush')
          assert_nil @klass.ensure_word_valid('arg', '000')
          assert_nil @klass.ensure_word_valid('arg', '极光推送_jpush')
          assert_nil @klass.ensure_word_valid('arg', '_极光推送')
          assert_nil @klass.ensure_word_valid('arg', '0_jpush')
        end

        def test_ensure_array_valid
          arr = ('0'..'100').to_a
          assert_equal 101, arr.size
          assert_raises ArgumentError do
            @klass.ensure_array_valid('array', arr, 100)
          end

          assert_nil @klass.ensure_array_valid('array', arr, 200)
        end

        def test_ensure_string_not_over_bytesize
          str = '极光推送_jpush'
          assert_equal 18, str.bytesize

          assert_raises ArgumentError do
            assert_nil @klass.ensure_string_not_over_bytesize('arg', str, 10)
          end

          assert_nil @klass.ensure_string_not_over_bytesize('arg', str, 18)
          assert_nil @klass.ensure_string_not_over_bytesize('arg', str, 20)
        end

        def test_ensure_array_not_over_bytesize
          array = ['极光推送', 'jpush', 'RANDOM_STRING'] # array_bytesize = 30

          assert_raises ArgumentError do
            assert_nil @klass.ensure_array_not_over_bytesize('arg', array, 10)
          end

          assert_nil @klass.ensure_array_not_over_bytesize('arg', array, 30)
          assert_nil @klass.ensure_array_not_over_bytesize('arg', array, 40)
        end

      end
    end
  end
end

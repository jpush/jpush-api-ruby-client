require 'test_helper'

module JPush
  module Api
    module Helper
      class ArgumentTest < JPush::Test

        def setup
          @klass = Class.new{ extend Argument }
        end

        def test_check_mobile
          assert_raises Utils::Exceptions::InvalidArgumentError  do
            @klass.check_mobile('1' * 11)
          end

          @klass.check_mobile('13800138000')
        end

        def test_ensure_argument_not_blank
          assert_raises Utils::Exceptions::InvalidArgumentError do
           @klass.ensure_argument_not_blank(arg: [])
          end
          assert_raises Utils::Exceptions::InvalidArgumentError do
           @klass.ensure_argument_not_blank(arg: {})
          end
          assert_raises Utils::Exceptions::InvalidArgumentError do
           @klass.ensure_argument_not_blank(arg: ' ')
          end
          assert_raises Utils::Exceptions::InvalidArgumentError do
           @klass.ensure_argument_not_blank(arg: nil)
          end
          assert_raises Utils::Exceptions::InvalidArgumentError do
           @klass.ensure_argument_not_blank(j: 'j', p: 'p', u: 'u', s: 's', h: 'h', args: '')
          end

          @klass.ensure_argument_not_blank(arg: 'RANDOM_STRING')
        end

        def test_ensure_argument_required
          assert_raises Utils::Exceptions::MissingArgumentError do
           @klass.ensure_argument_required(arg: nil)
          end
        end

        def test_ensure_word_valid
          assert_raises Utils::Exceptions::InvalidWordError do
            @klass.ensure_word_valid('arg', '')
          end
          assert_raises Utils::Exceptions::InvalidWordError do
            @klass.ensure_word_valid('arg', 'jpush#000')
          end
          assert_raises Utils::Exceptions::InvalidWordError do
            @klass.ensure_word_valid('arg', 'あいうえお')
          end
          assert_raises Utils::Exceptions::InvalidWordError do
            @klass.ensure_word_valid('arg', 'jpush@')
          end
          @klass.ensure_word_valid('arg', '极光推送')
          @klass.ensure_word_valid('arg', 'jpush')
          @klass.ensure_word_valid('arg', '000')
          @klass.ensure_word_valid('arg', '极光推送_jpush')
          @klass.ensure_word_valid('arg', '_极光推送')
          @klass.ensure_word_valid('arg', '0_jpush')
        end

        def test_ensure_not_over_bytesize
          string = '极光推送_jpush'
          assert_equal 18, string.bytesize
          assert_raises Utils::Exceptions::OverLimitError do
            @klass.ensure_not_over_bytesize('arg', string, 10)
          end
          @klass.ensure_not_over_bytesize('arg', string, 18)
          @klass.ensure_not_over_bytesize('arg', string, 20)

          array = ['极光推送', 'jpush', 'RANDOM_STRING']  # bytesize = 20
          assert_raises Utils::Exceptions::OverLimitError do
            @klass.ensure_not_over_bytesize('arg', array, 10)
          end
          @klass.ensure_not_over_bytesize('arg', array, 30)
          @klass.ensure_not_over_bytesize('arg', array, 40)

          hash = {jpush: '极光推送'}
          assert_equal 24, hash.to_json.bytesize
          assert_raises Utils::Exceptions::OverLimitError do
            @klass.ensure_not_over_bytesize('arg', hash, 20)
          end
          @klass.ensure_not_over_bytesize('arg', hash, 24)
          @klass.ensure_not_over_bytesize('arg', hash, 30)
        end

        def test_ensure_not_over_size
          assert_raises Utils::Exceptions::OverLimitError do
            @klass.ensure_not_over_size('arg', 'jpush', 4)
          end
          assert_raises Utils::Exceptions::OverLimitError do
            @klass.ensure_not_over_size('arg', ['j', 'p', 'u', 's', 'h'], 4)
          end
          @klass.ensure_not_over_size('arg', 'jpush', 5)
          @klass.ensure_not_over_size('arg', 'jpush', 6)
          @klass.ensure_not_over_size('arg', ['j', 'p', 'u', 's', 'h'], 6)
        end

      end
    end
  end
end

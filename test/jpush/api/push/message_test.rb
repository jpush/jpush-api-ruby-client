require 'test_helper'

module Jpush
  module Api
    module Push
      class MessageTest < Jpush::Test

        def test_new
          msg = Message.new(msg_content: 'jpush').build.to_hash
          assert_equal 1, msg.size
          assert_true msg.has_key?(:msg_content)
          assert_true msg[:msg_content].include?('jpush')
        end

        def test_init
          msg = Message.new(
            msg_content: 'jpush',
            title: 'hello',
            content_type: 'text',
            extras: {key0: 'value0', key1: 'value1'}
          ).build.to_hash

          assert_equal 4, msg.size
          assert_true msg.has_key?(:msg_content)
          assert_true msg.has_key?(:title)
          assert_true msg.has_key?(:content_type)
          assert_true msg.has_key?(:extras)
        end

      end
    end
  end
end

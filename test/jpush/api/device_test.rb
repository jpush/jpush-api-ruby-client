require 'test_helper'

module Jpush
  module Api

    class DeviceTest < Jpush::Test

      def setup
        @devices = @@jPush.devices
      end

      def test_show
        response = @devices.show($test_common_registration_id)
        assert_equal '200', response.code

        body = JSON.parse(response.body)
        assert_true body.has_key?('tags')
        assert_true body.has_key?('alias')
        assert_true body.has_key?('mobile')
      end

      def test_show_with_invalid_registration_id
        response = @devices.show('INVALID_REGISTRATION_ID')
        assert_equal '400', response.code

        body = JSON.parse(response.body)
        assert_equal 7002, body['error']['code']
      end

    end


    class TagTest < Jpush::Test

      def setup
        @tags = @@jPush.tags
      end

      def test_list
        response = @tags.list
        assert_equal '200', response.code

        body = JSON.parse(response.body)
        assert_equal 1, body.length
        assert_true body.has_key?('tags')
        assert_instance_of(Array, body['tags'])
      end

      def test_tag_has_device_with_blank_tag_value
        response = @tags.has_device?('', $test_common_registration_id)
        assert_equal '404', response.code
      end

      def test_tag_has_device_with_invalid_tag_value
        response = @tags.has_device?('INVALID_TAG', $test_common_registration_id)
        assert_equal '200', response.code

        body = JSON.parse(response.body)
        assert_true body.has_key?('result')
        assert_equal false, body['result']
      end

      def test_tag_has_device
        response = @tags.has_device?($test_common_tag, $test_common_registration_id)
        assert_equal '200', response.code

        body = JSON.parse(response.body)
        assert_equal true, body['result']
      end

    end

  end
end

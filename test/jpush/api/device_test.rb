require 'test_helper'

module Jpush
  module Api
    class DeviceTest < Jpush::Test

      def setup
        @devices = @@jPush.devices
      end

      def test_show
        response = @devices.show($test_common_registration_id)
        assert_equal 200, response.http_code

        body = response.body
        assert_true body.has_key?('tags')
        assert_true body.has_key?('alias')
        assert_true body.has_key?('mobile')
      end

      def test_show_with_invalid_registration_id
        response = @devices.show('INVALID_REGISTRATION_ID')
        assert_equal 400, response.http_code
        assert_equal 7002, response.error[:code]
      end

      def test_add_and_remove_tags
        body = @devices.show($test_common2_registration_id).body
        assert_true !body['tags'].include?($test_common_tag)

        response = @devices.add_tags($test_common2_registration_id, $test_common_tag)
        assert_equal 200, response.http_code

        body = @devices.show($test_common2_registration_id).body
        assert_true body['tags'].include?($test_common_tag)

        response = @devices.remove_tags($test_common2_registration_id, $test_common_tag)
        assert_equal 200, response.http_code

        body = @devices.show($test_common2_registration_id).body
        assert_true !body['tags'].include?($test_common_tag)
      end

      def test_add_invalid_tag_value
        @tags = @@jPush.tags

        body = @tags.list.body
        before_tag_len = body['tags'].length

        body = @devices.show($test_common_registration_id).body
        assert_true !body['tags'].include?('INVALID_TAG')

        response = @devices.add_tags($test_common_registration_id, 'INVALID_TAG')
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_true body['tags'].include?('INVALID_TAG')

        body = @tags.list.body
        after_tag_len = body['tags'].length
        assert_equal 1, after_tag_len - before_tag_len

        @tags.delete('INVALID_TAG')

        body = @devices.show($test_common_registration_id).body
        assert_true !body['tags'].include?('INVALID_TAG')

        body = @tags.list.body
        final_tag_len = body['tags'].length
        assert_equal final_tag_len, before_tag_len
      end

      def test_remove_Invalid_tag_value
        body = @devices.show($test_common_registration_id).body
        before_tag_len = body['tags'].length
        assert_true !body['tags'].include?('INVALID_TAG')

        response = @devices.remove_tags($test_common_registration_id, 'INVALID_TAG')
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        after_tag_len = body['tags'].length
        assert_true !body['tags'].include?('INVALID_TAG')
        assert_equal before_tag_len, after_tag_len
      end

      def test_clear_tags
        body = @devices.show($test_common2_registration_id).body
        assert_true !body['tags'].include?($test_common_tag)

        @devices.add_tags($test_common2_registration_id, $test_common_tag)

        body = @devices.show($test_common2_registration_id).body
        assert_true body['tags'].include?($test_common_tag)

        response = @devices.clear_tags($test_common2_registration_id)
        assert_equal 200, response.http_code

        body = @devices.show($test_common2_registration_id).body
        assert_true !body['tags'].include?($test_common_tag)
        assert_true body['tags'].empty?
      end

      def test_update_alias
        body = @devices.show($test_common_registration_id).body
        origin_alias = body['alias']

        response = @devices.update_alias($test_common_registration_id, 'JPUSH')
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_equal 'JPUSH', body['alias']

        response = @devices.update_alias($test_common_registration_id, '')
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_nil body['alias']

        response = @devices.update_alias($test_common_registration_id, origin_alias)
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_equal origin_alias, body['alias']
      end

      def test_update_mobile
        body = @devices.show($test_common_registration_id).body
        origin_mobile = body['mobile']

        response = @devices.update_mobile($test_common_registration_id, '13800138000')
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_equal 13800138000, body['mobile']

        response = @devices.update_mobile($test_common_registration_id, origin_mobile.to_s)
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        assert_equal origin_mobile, body['mobile']
      end

      def test_update_mobile_with_nil_value
        body = @devices.show($test_common_registration_id).body
        origin_mobile = body['mobile']

        response = @devices.update_mobile($test_common_registration_id, nil)
        assert_equal 200, response.http_code

        body = @devices.show($test_common_registration_id).body
        updated_mobile = body['mobile']

        assert_equal origin_mobile, updated_mobile
      end

      def test_device_status
        # TODO
        # need vip appKey
      end

    end
  end
end

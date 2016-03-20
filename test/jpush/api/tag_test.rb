require 'test_helper'

module Jpush
  module Api
    class TagTest < Jpush::Test

      def setup
        @tags = @@jPush.tags
      end

      def test_list
        response = @tags.list
        assert_equal 200, response.http_code

        body = response.body
        assert_equal 1, body.length
        assert_true body.has_key?('tags')
        assert_instance_of(Array, body['tags'])
      end

      def test_tag_has_device_with_invalid_argument
        response = @tags.has_device?($test_common_tag, 'INVALID_REGISTRATION_ID')
        assert_equal 400, response.http_code
        assert_equal 7002, response.error[:code]

        response = @tags.has_device?('INVALID_TAG', $test_common_registration_id)
        assert_equal 200, response.http_code
        body = response.body
        assert_true body.has_key?('result')
        assert_false body['result']
      end

      def test_tag_has_device
        response = @tags.has_device?($test_common_tag, $test_common_registration_id)
        assert_equal 200, response.http_code

        body = response.body
        assert_true body.has_key?('result')
        assert_true body['result']
      end

      def test_update
        assert_raises ArgumentError do
          @tags.update($test_common_tag)
        end
      end

      def test_add_and_remove_devices
        body = @tags.has_device?($test_common_tag, $test_common2_registration_id).body
        assert_false body['result']

        response = @tags.add_devices($test_common_tag, $test_common2_registration_id)
        assert_equal 200, response.http_code

        body = @tags.has_device?($test_common_tag, $test_common2_registration_id).body
        assert_true body['result']

        response = @tags.remove_devices($test_common_tag, $test_common2_registration_id)
        assert_equal 200, response.http_code

        body = @tags.has_device?($test_common_tag, $test_common2_registration_id).body
        assert_false body['result']
      end

      def test_update_with_invalid_tag_value
        invalid_tag = 'INVALID_TAG'

        body = @tags.has_device?(invalid_tag, $test_common_registration_id).body
        assert_false body['result']

        body = @tags.list.body
        before_tag_len = body['tags'].length

        response = @tags.add_devices(invalid_tag, $test_common_registration_id)
        assert_equal 200, response.http_code

        body = @tags.list.body
        after_tag_len = body['tags'].length

        body = @tags.has_device?(invalid_tag, $test_common_registration_id).body
        assert_true body['result']
        assert_equal 1, after_tag_len - before_tag_len

        @tags.delete(invalid_tag)

        body = @tags.list.body
        final_tag_len = body['tags'].length
        assert_equal before_tag_len, final_tag_len

        response = @tags.remove_devices(invalid_tag, $test_common_registration_id)
        assert_equal 200, response.http_code

        body = @tags.has_device?(invalid_tag, $test_common_registration_id).body
        assert_false body['result']

        body = @tags.list.body
        after_tag_len = body['tags'].length
        assert_equal after_tag_len, before_tag_len
      end

      def test_update_with_invalid_registration_id
        response = @tags.add_devices($test_common_tag, 'INVALID_REGISTRATION_ID')
        assert_equal 400, response.http_code
        assert_equal 7002, response.error[:code]

        response = @tags.remove_devices($test_common_tag, 'INVALID_REGISTRATION_ID')
        assert_equal 400, response.http_code
        assert_equal 7002, response.error[:code]
      end

      def test_update_with_too_much_registration_id
        registration_ids = (0..1000).to_a
        assert_equal 1001, registration_ids.count
        assert_raises ArgumentError do
          @tags.add_devices($test_common_tag, registration_ids)
        end
        assert_raises ArgumentError do
          @tags.remove_devices($test_common_tag, registration_ids)
        end
      end

      def test_delete_tag_with_invalid_tag_value
        body = @tags.list.body
        before_tag_len = body['tags'].length

        response = @tags.delete('INVALID_TAG')
        assert_equal 200, response.http_code

        body = @tags.list.body
        after_tag_len = body['tags'].length

        assert_equal before_tag_len, after_tag_len
      end

      def test_delete_tag
        body = @tags.list.body
        before_tag_len = body['tags'].length
        assert_true body['tags'].include?($test_common_tag)

        response = @tags.delete($test_common_tag)
        assert_equal 200, response.http_code

        body = @tags.list.body
        after_tag_len = body['tags'].length
        assert_false body['tags'].include?($test_common_tag)
        assert_equal 1, before_tag_len  - after_tag_len

        @tags.add_devices($test_common_tag, $test_common_registration_id)

        body = @tags.list.body
        final_tag_len = body['tags'].length
        assert_true body['tags'].include?($test_common_tag)
        assert_equal before_tag_len, final_tag_len

        body = @tags.has_device?($test_common_tag, $test_common_registration_id).body
        assert_true body['result']
      end

    end
  end
end

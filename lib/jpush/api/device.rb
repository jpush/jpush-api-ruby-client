require 'jpush/api/helper/argument_check'
require 'jpush/http/client'

module Jpush
  module Api
    module Device
      extend self
      extend Helper::ArgumentCheck
      using Utils::Helper::ObjectExtensions

      # GET /v3/devices/{registration_id}
      # 获取当前设备的所有属性
      def show(registration_id)
        check_registration_id(registration_id)
        url = base_url + registration_id
        Http::Client.get(url)
      end

      # POST /v3/devices/{registration_id}
      # 更新当前设备的指定属性，当前支持tags, alias，手机号码mobile
      def update(registration_id, tags_add: nil, tags_remove: nil, clear_tags: false, alis: nil, mobile: nil)
        check_registration_id(registration_id)
        check_mobile(mobile) unless mobile.nil?
        tags =
          if clear_tags
            ''
          else
            tags_add = build_tags(tags_add) unless tags_add.nil?
            tags_remove = build_tags(tags_remove) unless tags_remove.nil?
            tags = { add: tags_add, remove: tags_remove }.reject{ |key, value| value.nil? }
            tags.empty? ? nil : tags
          end
        body = {
          tags: tags,
          alias: alis,
          mobile: mobile
        }
        body = body.reject { |key, value| value.nil? }

        raise ArgumentError, 'Invalid Arguments' if body.empty?

        url = base_url + registration_id
        Http::Client.post(url, body: body)
      end

      # 下面两个方法接受一个参数,其类型为数组或字符串
      def add_tags(registration_id, tags)
        ensure_argument_not_nil('tags', tags)
        update(registration_id, tags_add: tags)
      end

      def remove_tags(registration_id, tags)
        ensure_argument_not_nil('tags', tags)
        update(registration_id, tags_remove: tags)
      end

      def clear_tags(registration_id)
        update(registration_id, clear_tags: true)
      end

      def update_alias(registration_id, alis)
        ensure_argument_not_nil('alias', alis)
        update(registration_id, alis: alis)
      end

      def update_mobile(registration_id, mobile)
        update(registration_id, mobile: mobile)
      end

      # 获取用户在线状态
      # POST /v3/devices/status/
      def status(registration_ids)
        registration_ids = [registration_ids].flatten.compact.reject{ |id| id.blank? }.uniq
        ensure_argument_not_blank('registration ids', registration_ids)
        raise ArgumentError, "too much registration ids(<=1000)".titleize if registration_ids.length > 1000
        url = base_url + 'status'
        body = { registration_ids: registration_ids }
        Http::Client.post(url, body: body)
      end

      private

        def build_tags(tags)
          # remove blank elements in tags array
          tags = [tags].flatten.compact.reject{ |tag| tag.blank? }.uniq
          ensure_argument_not_blank('tags', tags)
          tags
        end

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/devices/'
        end

    end


    module Tag
      extend self
      extend Helper::ArgumentCheck
      using Utils::Helper::ObjectExtensions

      # GET /v3/tags/
      # 获取当前应用的所有标签列表。
      def list
        url = base_url
        Http::Client.get(url)
      end

      # GET /v3/tags/{tag_value}/registration_ids/{registration_id}
      # 查询某个设备是否在 tag 下
      def has_device?(tag_value, registration_id)
        check_registration_id(registration_id)
        ensure_argument_not_blank('tag', tag_value)
        url = base_url + "#{tag_value}/registration_ids/#{registration_id}"
        Http::Client.get(url)
      end

      # POST /v3/tags/{tag_value}
      # 为一个标签添加或者删除设备。
      def update(tag_value, devices_add: nil, devices_remove: nil)
        ensure_argument_not_blank('tag', tag_value)

        devices_add = build_registration_ids(devices_add) unless devices_add.nil?
        devices_remove = build_registration_ids(devices_remove) unless devices_remove.nil?
        registration_ids = { add: devices_add, remove: devices_remove }.reject{ |key, value| value.nil? }
        ensure_argument_not_blank('registration ids', registration_ids)

        devices_add_count = registration_ids[:add].nil? ? 0 : registration_ids[:add].count
        devices_remove_count = registration_ids[:remove].nil? ? 0 : registration_ids[:remove].count
        if devices_add_count > 1000 || devices_remove_count > 1000
          raise ArgumentError, "too much registration ids(<=1000)".titleize
        end

        body = { registration_ids: registration_ids }
        url = base_url + tag_value
        Http::Client.post(url, body: body)
      end

      # 下面两个方法接受一个参数,其类型为数组或字符串
      def add_devices(tag_value, registration_ids)
        ensure_argument_not_nil('registration ids', registration_ids)
        update(tag_value, devices_add: registration_ids)
      end

      def remove_devices(tag_value, registration_ids)
        ensure_argument_not_nil('registration ids', registration_ids)
        update(tag_value, devices_remove: registration_ids)
      end

      # DELETE /v3/tags/{tag_value}
      # 删除一个标签，以及标签与设备之间的关联关系
      def delete(tag_value)
        ensure_argument_not_blank('tag', tag_value)
        url = base_url + tag_value
        Http::Client.delete(url)
      end

      private

        def build_registration_ids(ids)
          # remove blank elements in registration_ids array
          ids = [ids].flatten.compact.reject{ |id| id.blank? }.uniq
          ensure_argument_not_blank('registration ids', ids)
          ids
        end

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/tags/'
        end

    end


    module Alias
      extend self
      extend Helper::ArgumentCheck

      # GET /v3/aliases/{alias_value}
      # 获取指定alias下的设备，最多输出10个
      def show(alias_value)
        ensure_argument_not_blank('alias', alias_value)
        url = base_url + alias_value
        Http::Client.get(url)
      end

      # DELETE /v3/aliases/{alias_value}
      # 删除一个别名，以及该别名与设备的绑定关系
      def delete(alias_value)
        ensure_argument_not_blank('alias', alias_value)
        url = base_url + alias_value
        Http::Client.delete(url)
      end

      private

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/aliases/'
        end

    end

  end
end

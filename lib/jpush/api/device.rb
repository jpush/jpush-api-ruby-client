require 'jpush/http/client'

module Jpush
  module Api
    module Device
      extend self

      # GET /v3/devices/{registration_id}
      # 获取当前设备的所有属性
      def show(registration_id)
        url = base_url + registration_id
        Http::Client.get(url)
      end

      # POST /v3/devices/{registration_id}
      # 更新当前设备的指定属性，当前支持tags, alias，手机号码mobile
      def update(registration_id, tags: nil, alis: nil, mobile: nil)
        url = base_url + registration_id
        body = {
          tags: tags,
          alias: alis,
          mobile: mobile
        }
        body = body.delete_if { |key, value| value.nil? }
        Http::Client.post(url, body: body)
      end

      # 下面两个方法接受一个参数,其类型为数组或字符串
      def add_tags(registration_id, tags)
        update(registration_id, tags: { add: [tags].flatten.compact })
      end

      def remove_tags(registration_id, tags)
        update(registration_id, tags: { remove: [tags].flatten.compact })
      end

      def clear_tags(registration_id)
        update(registration_id, tags: '')
      end

      def update_alias(registration_id, alis)
        update(registration_id, alis: alis)
      end

      def update_mobile(registration_id, mobile)
        update(registration_id, mobile: mobile)
      end

      # 获取用户在线状态
      # POST /v3/devices/status/
      def status(registration_ids)
        url = base_url + 'status'
        body = { registration_ids: [registration_ids].flatten }
        Http::Client.post(url, body: body)
      end

      private

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/devices/'
        end

    end


    module Tag
      extend self

      # GET /v3/tags/
      # 获取当前应用的所有标签列表。
      def list
        url = base_url
        Http::Client.get(url)
      end

      # GET /v3/tags/{tag_value}/registration_ids/{registration_id}
      # 查询某个设备是否在 tag 下
      def has_device?(tag_value, registration_id)
        url = base_url + "#{tag_value}/registration_ids/#{registration_id}"
        Http::Client.get(url)
      end

      # POST /v3/tags/{tag_value}
      # 为一个标签添加或者删除设备。
      def update(tag_value, add: nil, remove: nil)
        url = base_url + tag_value
        body = {
          registration_ids: {
            add: [add].flatten.compact,
            remove: [remove].flatten.compact
          }
        }
        add_count = body[:registration_ids][:add].count
        remove_count = body[:registration_ids][:remove].count
        if add_count > 1000 || remove_count > 1000
          raise "too much registration ids"
        end
        Http::Client.post(url, body: body)
      end

      # 下面两个方法接受一个参数,其类型为数组或字符串
      def add_devices(tag_value, registration_ids)
        update(tag_value, add: registration_ids)
      end

      def remove_devices(tag_value, registration_ids)
        update(tag_value, remove: registration_ids)
      end

      # DELETE /v3/tags/{tag_value}
      # 删除一个标签，以及标签与设备之间的关联关系
      def delete(tag_value)
        url = base_url + tag_value
        Http::Client.delete(url)
      end

      private

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/tags/'
        end

    end


    module Alias
      extend self

      # GET /v3/aliases/{alias_value}
      # 获取指定alias下的设备，最多输出10个
      def show(alias_value)
        url = base_url + alias_value
        Http::Client.get(url)
      end

      # DELETE /v3/aliases/{alias_value}
      # 删除一个别名，以及该别名与设备的绑定关系
      def delete(alias_value)
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

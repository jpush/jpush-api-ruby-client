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
  end
end

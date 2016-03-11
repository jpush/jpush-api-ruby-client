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

      private

        def base_url
          Config.settings[:device_api_host] + Config.settings[:api_version] + '/tags/'
        end

    end
  end
end

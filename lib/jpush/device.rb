require 'jpush/http/client'
require 'jpush/handler'

module JPush
  class Device < Handler

    # GET /v3/devices/{registration_id}
    # 获取当前设备的所有属性
    def show(registration_id)
      url = base_url + registration_id
      Http::Client.get(@jpush, url)
    end

    # POST /v3/devices/{registration_id}
    # 更新当前设备的指定属性，当前支持tags, alias，手机号码mobile
    def update(registration_id, tags_add: nil, tags_remove: nil, clear_tags: false, alis: nil, mobile: nil)
      tags =
        if clear_tags
            ''
        else
          hash = {}
          hash[:add] = [tags_add].flatten unless tags_add.nil?
          hash[:remove] = [tags_remove].flatten unless tags_remove.nil?
          hash.empty? ? nil : hash
        end
      body = {
        tags: tags,
        alias: alis,
        mobile: mobile
      }.select { |_, value| !value.nil? }

      url = base_url + registration_id
      Http::Client.post(@jpush, url, body: body)
    end

    # 下面两个方法接受一个参数,其类型为数组或字符串
    def add_tags(registration_id, tags)
      update(registration_id, tags_add: tags)
    end

    def remove_tags(registration_id, tags)
      update(registration_id, tags_remove: tags)
    end

    def clear_tags(registration_id)
      update(registration_id, clear_tags: true)
    end

    def update_alias(registration_id, alis)
      update(registration_id, alis: alis)
    end

    def delete_alias(registration_id)
      update(registration_id, alis: '')
    end

    def update_mobile(registration_id, mobile)
      update(registration_id, mobile: mobile)
    end

    # 获取用户在线状态
    # POST /v3/devices/status/
    def status(registration_ids)
      registration_ids = [registration_ids].flatten
      url = base_url + 'status'
      body = { registration_ids: registration_ids }
      Http::Client.post(@jpush, url, body: body)
    end

    private

      def base_url
        'https://device.jpush.cn/v3/devices/'
      end

  end


  class Tag < Handler

    # GET /v3/tags/
    # 获取当前应用的所有标签列表。
    def list
      url = base_url
      Http::Client.get(@jpush, url)
    end

    # GET /v3/tags/{tag_value}/registration_ids/{registration_id}
    # 查询某个设备是否在 tag 下
    def has_device?(tag_value, registration_id)
      url = base_url + "#{tag_value}/registration_ids/#{registration_id}"
      Http::Client.get(@jpush, url)
    end

    # POST /v3/tags/{tag_value}
    # 为一个标签添加或者删除设备。
    def update(tag_value, devices_add: nil, devices_remove: nil)
      rids = {}
      rids[:add] = [devices_add].flatten unless devices_add.nil?
      rids[:remove] = [devices_remove].flatten unless devices_remove.nil?

      body = { registration_ids: rids }
      url = base_url + tag_value
      Http::Client.post(@jpush, url, body: body)
    end

    # 下面两个方法接受一个参数,其类型为数组或字符串
    def add_devices(tag_value, registration_ids)
      update(tag_value, devices_add: registration_ids)
    end

    def remove_devices(tag_value, registration_ids)
      update(tag_value, devices_remove: registration_ids)
    end

    # DELETE /v3/tags/{tag_value}
    # 删除一个标签，以及标签与设备之间的关联关系
    def delete(tag_value, platform = nil)
      params = platform.nil? ? nil : { platform: [platform].flatten.join(',') }
      url = base_url + tag_value
      Http::Client.delete(@jpush, url, params: params)
    end

    private

      def base_url
        'https://device.jpush.cn/v3/tags/'
      end

  end


  class Alias < Handler

    # GET /v3/aliases/{alias_value}
    # 获取指定alias下的设备，最多输出10个
    def show(alias_value, platform = nil)
      params = platform.nil? ? nil : { platform: build_platform(platform) }
      url = base_url + alias_value
      Http::Client.get(@jpush, url, params: params)
    end

    # DELETE /v3/aliases/{alias_value}
    # 删除一个别名，以及该别名与设备的绑定关系
    def delete(alias_value, platform = nil)
      params = platform.nil? ? nil : { platform: build_platform(platform) }
      url = base_url + alias_value
      Http::Client.delete(@jpush, url, params: params)
    end

    private

      def base_url
        'https://device.jpush.cn/v3/aliases/'
      end

      def build_platform(p)
        [p].flatten.join(',')
      end

  end

end

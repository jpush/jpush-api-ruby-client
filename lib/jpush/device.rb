require 'jpush/helper/argument_helper'
require 'jpush/http/client'

module JPush
  module Device
    extend self
    extend Helper::ArgumentHelper
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
      check_alias(alis) unless alis.nil?
      tags =
        if clear_tags
          ''
        else
          tags_add = build_tags(tags_add) unless tags_add.nil?
          tags_remove = build_tags(tags_remove) unless tags_remove.nil?
          tags = { add: tags_add, remove: tags_remove }.compact
          tags.empty? ? nil : tags
        end
      body = {
        tags: tags,
        alias: alis,
        mobile: mobile
      }.compact

      raise Utils::Exceptions::JPushError, 'Devices update body can not be empty' if body.empty?

      url = base_url + registration_id
      Http::Client.post(url, body: body)
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
      registration_ids = build_registration_ids(registration_ids)
      url = base_url + 'status'
      body = { registration_ids: registration_ids }
      Http::Client.post(url, body: body)
    end

    private

      def base_url
        Config.settings[:device_api_host] + Config.settings[:api_version] + '/devices/'
      end

  end


  module Tag
    extend self
    extend Helper::ArgumentHelper
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
      check_tag(tag_value)
      url = base_url + "#{tag_value}/registration_ids/#{registration_id}"
      Http::Client.get(url)
    end

    # POST /v3/tags/{tag_value}
    # 为一个标签添加或者删除设备。
    def update(tag_value, devices_add: nil, devices_remove: nil)
      check_tag(tag_value)

      devices_add = build_registration_ids(devices_add) unless devices_add.nil?
      devices_remove = build_registration_ids(devices_remove) unless devices_remove.nil?
      registration_ids = { add: devices_add, remove: devices_remove }.compact

      raise Utils::Exceptions::JPushError, 'Tags update body can not be empty.' if registration_ids.empty?

      body = { registration_ids: registration_ids }
      url = base_url + tag_value
      Http::Client.post(url, body: body)
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
      check_tag(tag_value)
      params = platform.nil? ? nil : { platform: build_platform(platform) }
      url = base_url + tag_value
      Http::Client.delete(url, params: params)
    end

    private

      def base_url
        Config.settings[:device_api_host] + Config.settings[:api_version] + '/tags/'
      end

  end


  module Alias
    extend self
    extend Helper::ArgumentHelper

    # GET /v3/aliases/{alias_value}
    # 获取指定alias下的设备，最多输出10个
    def show(alias_value, platform = nil)
      check_alias(alias_value)
      params = platform.nil? ? nil : { platform: build_platform(platform) }
      url = base_url + alias_value
      Http::Client.get(url, params: params)
    end

    # DELETE /v3/aliases/{alias_value}
    # 删除一个别名，以及该别名与设备的绑定关系
    def delete(alias_value, platform = nil)
      check_alias(alias_value)
      params = platform.nil? ? nil : { platform: build_platform(platform) }
      url = base_url + alias_value
      Http::Client.delete(url, params: params)
    end

    private

      def base_url
        Config.settings[:device_api_host] + Config.settings[:api_version] + '/aliases/'
      end

  end

end

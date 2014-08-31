path= File.expand_path('../', __FILE__)
require File.join(path, 'http_client.rb')
require File.join(path, 'model/push_result.rb')
require 'json'

=begin
Entrance for Device api.
=end
module JPush
  class DeviceClient
    @@DEVICE_HOST_NAME = 'https://device.jpush.cn'
    @@DEVICE_PATH = '/v3/device/'
    @@TAG_PATH_LIST = '/v3/tag/list'
    
    def initialize(maxRetryTimes)
      @httpclient = JPush::NativeHttpClient.new(maxRetryTimes)
    end

    def getUserProfile(registration_id)
      url = @@DEVICE_HOST_NAME + @@DEVICE_PATH + registration_id
      return @httpclient.sendGet(url, nil)
    end

    def updateUserDeviceProfile(registration_id, tagAlias)
      json_data = JSON.generate(tagAlias.toJSON)
      url = @@DEVICE_HOST_NAME + @@DEVICE_PATH + registration_id
      return @httpclient.sendPost(url, json_data, autoCode)
    end

    def getAppkeyTagList()
      url = @@DEVICE_HOST_NAME + @@TAG_PATH_LIST
      return @httpclient.sendGet(url, nil)
    end

    def userExistsInTag(tag_value, registration_id)
      url = @@DEVICE_HOST_NAME + '/v3/tag/' + tag_value + '/exist?registration_id=' + registration_id
      return @httpclient.sendGet(url, nil)
    end
    
    def  tagAddingOrRemovingUsers(tag_value, registration_ids)
      json_data = JSON.generate(registration_ids.toJSON)
      url = @@DEVICE_HOST_NAME + 'v3/tag/' + tag_value
      return @httpclient.sendPost(url, json_data, autoCode)
    end
    
    def tagDelete(tag_value, platform)
      json_platform = JSON.generate(platform.toJSON)
      url = @@DEVICE_HOST_NAME + '/v3/tag/' + tag_value + '?platform=' + json_platform
      return @httpclient.sendDelete(url, nil)
    end
    
    def getAliasUids(alias_value, platform)
      json_platform = JSON.generate(platform.toJSON)
      url = @@DEVICE_HOST_NAME + '/v3/alias/' + alias_value + '?platform=' + json_platform
      return @httpclient.sendGet(url, nil)
    end
    
    def aliasDelete(alias_value, platform)
      json_platform = JSON.generate(platform.toJSON)
      url = @@DEVICE_HOST_NAME + '/v3/alias/' + tag_value + '?platform=' + json_platform
      return @httpclient.sendDelete(url, nil)
    end
    
  end
end
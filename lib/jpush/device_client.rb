path= File.expand_path('../', __FILE__)
require File.join(path, 'http_client.rb')
require File.join(path, 'model/tag_list.rb')
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
      result = JPush::UserProfile.new
      url = @@DEVICE_HOST_NAME + @@DEVICE_PATH + registration_id + '/'
      wrapper = @httpclient.sendGet(url, nil)
      result.fromResponse(wrapper)
      return result
    end

    def updateUserDeviceProfile(registration_id, tagAlias)
      json_data = JSON.generate(tagAlias.toJSON)
      url = @@DEVICE_HOST_NAME + @@DEVICE_PATH + registration_id + '/'
      return @httpclient.sendPost(url, json_data)
    end

    def getAppkeyTagList()
      url = @@DEVICE_HOST_NAME + @@TAG_PATH_LIST + '/'
      tag_list = JPush::TagList.new
      wrapper =  @httpclient.sendGet(url, nil)
      tag_list.fromResponse(wrapper)
      return wrapper
    end

    def userExistsInTag(tag_value, registration_id)
      result = JPush::ExistResult.new
      url = @@DEVICE_HOST_NAME + '/v3/tag/' + tag_value + '/exist?registration_id=' + registration_id + '/'
      wrapper = @httpclient.sendGet(url, nil)
      result.fromResponse(wrapper)
      return wrapper
    end
    
    def  tagAddingOrRemovingUsers(tag_value, tagManager)
      json_data = JSON.generate(tagManager.toJSON)
      url = @@DEVICE_HOST_NAME + 'v3/tag/' + tag_value + '/'
      return @httpclient.sendPost(url, json_data)
    end
    
    def tagDelete(tag_value, platform)

      url = @@DEVICE_HOST_NAME + '/v3/tag/' + tag_value 
      if platform != nil
        url = url + '?platform=' + platform + '/'
      else
        url = url + '/'
      end
      return @httpclient.sendDelete(url, nil)
    end
    
    def getAliasUids(alias_value, platform)
      aliasUids = JPush::AliasUids.new
      url = @@DEVICE_HOST_NAME + '/v3/alias/' + alias_value
      if platform != nil
        url = url + '?platform=' + platform + '/'
      else
        url = url + '/'
      end
      puts url
      wrapper = @httpclient.sendGet(url, nil)
      aliasUids.fromResponse(wrapper)
      return aliasUids
    end
    
    def aliasDelete(alias_value, platform)
      url = @@DEVICE_HOST_NAME + '/v3/alias/' + tag_value
      if platform != nil
        url = url + '?platform=' + platform + '/'
      else
        url = url + '/'
      end
      return @httpclient.sendDelete(url, nil)
    end
    
  end
end
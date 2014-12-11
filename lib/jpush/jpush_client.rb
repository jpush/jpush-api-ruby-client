path =  File.expand_path('../', __FILE__)
require File.join(path, 'http_client.rb')
require File.join(path, 'push_client.rb')
require File.join(path, 'report_client.rb')
require File.join(path, 'util/service_helper.rb')

module JPush
=begin
The global entrance of JPush API library.
=end
  class JPushClient
=begin
Create a JPush Client.
masterSecret API access secret of the appKey.
appKey The KEY of one application on JPush.
=end
    def initialize(appkey, masterSecret, maxRetryTimes = 5)
      begin
        @logger = Logger.new(STDOUT)
        if appkey.class == String && appkey.length == 24 then
          @appkey = appkey
        else
          @logger.error('appkey is format error  ')
        end
        if masterSecret.class == String && masterSecret.length == 24 then
          @masterSecret = masterSecret

        else
          @logger.error('masterSecret is format error')
        end
      end
      @masterSecret = masterSecret
      @pushClient = JPush::PushClient.new(maxRetryTimes = maxRetryTimes)
      @reportClient = JPush::ReportClient.new(maxRetryTimes = maxRetryTimes)
      @deviceClient = JPush::DeviceClient.new(maxRetryTimes = maxRetryTimes)
      $authcode = ServiceHelper.getAuthorizationBase64(appkey, masterSecret)
    end

    # Send a push with object.
    # @param pushPayload payload object of a push.
    # @return JSON data.
    def sendPush(payload)
      @currentClient = @pushClient
      result = @pushClient.sendPush(payload)
      return  result
    end

    def validate(payload)
      @currentClient = @pushClient
      result = @pushClient.validate(payload)
      return result
    end

    #Get received report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportReceiveds(msgIds)
      @currentClient = @reportClient
      result = @reportClient.getReceiveds(msgIds)
      return result
    end

    #Get message report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportMessages(msgIds)
      @currentClient = @reportClient
      result =  @reportClient.getMessages(msgIds)
      return result
    end

    #Get user report.
    #@param timeunit is 'DAY','HOUR' or 'MONTH'
    #@param start is a string for example 2014-06-10
    #@duration
    # @return JSON data.
    def getReportUsers(timeUnit, start, duration)
      @currentClient = @reportClient
      result =  @reportClient.getUsers(timeUnit, start, duration)
      return result
    end

    # Get user profile
    #@param registration_id
    #Response Data
    #{
    #  "tags": ["tag1", "tag2"],
    #  "alias": "alias1"  }
    def getDeviceTagAlias(registration_id)
      @currentClient = @deviceClient
      return @deviceClient.getDeviceTagAlias(registration_id)
    end

=begin
Update user device profile
@param registration_id
@param tagAlias
=end
    def updateDeviceTagAlias(registration_id, tagAlias)
      @currentClient = @deviceClient
      return @deviceClient.updateDeviceTagAlias(registration_id, tagAlias);
    end

=begin
Appkey Tag List
=end
    def getAppkeyTagList()
      @currentClient = @deviceClient
      return @deviceClient.getAppkeyTagList
    end

=begin
User Exists In Tag
@param tag_value
@param registration_id
=end
    def userExistsInTag(tag_value, registration_id)
      @currentClient = @deviceClient
      return @deviceClient.userExistsInTag(tag_value, registration_id)
    end

=begin
Tag Adding or Removing Users
@param tag_value
@param registration_ids
=end
    def  tagAddingOrRemovingUsers(tag_value, registration_ids)
      @currentClient = @deviceClient
      return @deviceClient.tagAddingOrRemovingUsers(tag_value, registration_ids)
    end

=begin
Tag Delete
@param tag_value
@param platform default is all
=end
    def tagDelete(tag_value, platform = nil)
      @currentClient = @deviceClient
      return @deviceClient.tagDelete(tag_value, platform)
    end

=begin
get alias uids
@param alias_value
@param platform default is all
=end
    def getAliasUids(alias_value, platform = nil)
      @currentClient = @deviceClient
      return @deviceClient.getAliasUids(alias_value, platform)
    end

=begin
Alias Delete
@param alias_value
@param  platform
=end
    def aliasDelete(alias_value, platform = nil)
      @currentClient = @deviceClient
      return @deviceClient.aliasDelete(alias_value, platform)
    end

=begin
fetch response code and response body or errors
=end
    def response_wrapper
      @currentClient.instance_variable_get(:@httpclient).response_wrapper
    end
  end
end

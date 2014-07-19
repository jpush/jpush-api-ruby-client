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
      @authcode = ServiceHelper.getAuthorizationBase64(appkey, masterSecret)
    end

    # Send a push with object.
    # @param pushPayload payload object of a push.
    # @return JSON data.
    def sendPush(payload)
      result = @pushClient.sendPush(payload, @authcode)
      return  result
    end

    #Get received report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportReceiveds(msgIds)
      result = @reportClient.getReceiveds(msgIds, @authcode)
      return result
    end

    #Get message report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportMessages(msgIds)
      result =  @reportClient.getMessages(msgIds, @authcode)
      return result
    end

    #Get user report.
    #@param timeunit is 'DAY','HOUR' or 'MONTH'
    #@param start is a string for example 2014-06-10
    #@duration
    # @return JSON data.

    def getReportUsers(timeUnit, start, duration)
      result =  @reportClient.getUsers(timeUnit, start, duration, @authcode)
      return result
    end

  end
end

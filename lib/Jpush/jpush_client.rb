path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require File.join(path, 'PushClient.rb')
require File.join(path, 'ReportClient.rb')
require File.join(path, 'util/ServiceHelper.rb')

module JPushApiRubyClient
=begin
The global entrance of JPush API library.
=end
  class JPushClient
=begin
Create a JPush Client.
masterSecret API access secret of the appKey.
appKey The KEY of one application on JPush.
=end
    def initialize(appkey,masterSecret,maxRetryTimes=5)
      begin
      @logger = Logger.new(STDOUT);
      if appkey.class==String&&appkey.length==24 then
        @appkey=appkey;
      else
        @logger.error('appkey is formal error ; ');
      end
      if masterSecret.class==String&&masterSecret.length==24 then
        @masterSecret=masterSecret;
      else
        @logger.error('masterSecret is formal error')
      end
     end
      @masterSecret=masterSecret;
      @pushClient=JPushApiRubyClient::PushClient.new(maxRetryTimes=maxRetryTimes);
      @reportClient=JPushApiRubyClient::ReportClient.new(maxRetryTimes=maxRetryTimes);
      @authcode=ServiceHelper.getAuthorizationBase64(appkey,masterSecret);
    end

     # Send a push with object.
     # @param pushPayload payload object of a push. 
    # @return JSON data.
    def sendPush(payload)
      response=@pushClient.sendPush(payload,@authcode);
      return  response.body
    end

    #Get received report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportReceiveds(msgIds)
      response= @reportClient.getReceiveds(msgIds,@authcode)
      return response.body;
    end

    #Get message report.
    # @param msgIds 100 msgids to batch getting is supported.
    # @return JSON data.
    def getReportMessages(msgIds)
      response= @reportClient.getMessages(msgIds,@authcode)
      return response.body;
    end

    #Get user report.
    #@param timeunit is 'DAY','HOUR' or 'MONTH'
    #@param start is a string for example 2014-06-10
    #@duration
    # @return JSON data.
    def getReportUsers(timeUnit,start,duration)
      response= @reportClient.getUsers(timeUnit,start,duration,@authcode)
      return response.body;
    end
  end
end
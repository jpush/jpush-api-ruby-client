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
  def initialize(appkey,masterSecret)
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
    
    
    @masterSecret=masterSecret;
    @pushClient=JPushApiRubyClient::PushClient.new;
    @reportClient=JPushApiRubyClient::ReportClient.new;
    @authcode=ServiceHelper.getAuthorizationBase64(appkey,masterSecret);
  end
  
  def sendPush(payload)
    response=@pushClient.sebdPush(payload,@authcode);
       return  response.body
  end
  
  def getReportMessages(msgIds)
     return @reportClient.getMessagesOrReceiveds(msgIds,@authcode);
  end
end
end

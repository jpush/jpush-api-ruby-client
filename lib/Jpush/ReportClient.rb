path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require File.join(path, 'PushClient.rb')
require 'json'
module JPushApiRubyClient
class ReportClient
   @@RECEIVE_API_URL = 'https://report.jpush.cn/v3/received';
  
  def getMessagesOrReceiveds(msg_ids,authcode)
    @url=@@RECEIVE_API_URL+'?msg_ids='+msg_ids;
    @httpclient=JPushApiRubyClient::NativeHttpClient.new
    return @httpclient.sendGet(@url,nil,authcode)
  end
end
end

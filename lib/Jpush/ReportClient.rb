path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require File.join(path, 'PushClient.rb')
require 'json'

class ReportClient
   @RECEIVE_API_URL = "https://report.jpush.cn/v2/received";
  
  def getMessages(msg_ids,autocode)
    @url=RECEIVE_API_URL+'?msg_ids'+msg_ids;
    @httpclient=NativeHttpClient.new
    return httpclient.sendPost(@RECEIVE_API_URL,nil,autoCode)
  end
end
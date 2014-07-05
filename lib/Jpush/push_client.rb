path= File.expand_path('../', __FILE__)
require File.join(path, 'http_client.rb')
require 'json'
=begin
Entrance for sending Push.
timeToLive If not present, the default is 86400(s) (one day). 
=end
module JPush
class PushClient
   @@PUSH_API_URL = 'https://api.jpush.cn/v3/push';
   @@_timeToLive = 60 * 60 * 24;
  def initialize(maxRetryTimes)
      @httpclient=JPush::NativeHttpClient.new(maxRetryTimes);
  end
=begin
 @param payload is the instance of PushPayload
 @autoCode
=end
  def sendPush(payload,autoCode)
    json_data=JSON.generate(payload.toJSON)
    return @httpclient.sendPsot(@@PUSH_API_URL,json_data,autoCode)
  end
end
end

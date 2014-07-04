path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require 'json'
module JPushApiRubyClient
class PushClient
   @@PUSH_API_URL = 'https://api.jpush.cn/v3/push';
   @@_timeToLive = 60 * 60 * 24;
  def initialize(maxRetryTimes)
      @httpclient=JPushApiRubyClient::NativeHttpClient.new(maxRetryTimes);
  end

  def sendPush(payload,autoCode)
    
    json_data=JSON.generate(payload.toJSON)
    return @httpclient.sendPsot(@@PUSH_API_URL,json_data,autoCode)
  end
end
end
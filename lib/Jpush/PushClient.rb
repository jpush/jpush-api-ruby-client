path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require 'json'

class PushClient
   @@PUSH_API_URL = 'https://api.jpush.cn/v3/push';
   @@_timeToLive = 60 * 60 * 24;
  def initialize(maxRetryTimes=0)
      @httpclient=NativeHttpClient.new(maxRetryTimes);
  end

  def sebdPush(payload,autoCode)
    
    json_data=payload.toJSON.to_json
    puts @@PUSH_API_URL
    return @httpclient.sendPsot(@@PUSH_API_URL,json_data,autoCode)
  end
end

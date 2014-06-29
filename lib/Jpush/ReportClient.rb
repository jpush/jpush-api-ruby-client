path= File.expand_path('../', __FILE__)
require File.join(path, 'NativeHttpClient.rb')
require File.join(path, 'PushClient.rb')
require 'json'

module JPushApiRubyClient
  class ReportClient
    @@REPORT_HOST_NAME = "https://report.jpush.cn";
    @@REPORT_RECEIVE_PATH = "/v3/received";
    @@REPORT_USER_PATH = "/v3/users";
    @@REPORT_MESSAGE_PATH = "/v3/messages";
    
    def getReceiveds(msg_ids,authcode)
      @url=@@REPORT_HOST_NAME+@@REPORT_RECEIVE_PATH+'?msg_ids='+msg_ids;
      @httpclient=JPushApiRubyClient::NativeHttpClient.new
      return @httpclient.sendGet(@url,nil,authcode)
    end

    def getMessages(msg_ids,authcode)
      @url=@@REPORT_HOST_NAME+@@REPORT_MESSAGE_PATH+'?msg_ids='+msg_ids;
      @httpclient=JPushApiRubyClient::NativeHttpClient.new
      return @httpclient.sendGet(@url,nil,authcode)
    end

    def getUsers(timeUnit,start,duration,authcode)
      @url = @@REPORT_HOST_NAME + @@REPORT_USER_PATH+ "?time_unit=" + timeUnit+ "&start=" + start + "&duration=" + duration;
      @httpclient=JPushApiRubyClient::NativeHttpClient.new
      return @httpclient.sendGet(@url,nil,authcode)
    end
  end
end
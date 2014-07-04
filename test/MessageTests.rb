require 'jpush_api_ruby_client'

require './BaseRemoteTests.rb';

require 'test/unit'

class MessageTests < Test::Unit::TestCase
  def setup
    @client=JPushApiRubyClient::JPushClient.new(AppKey, MasterSecret);
  end

  def testsendMessageContentOnly
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    message=JPushApiRubyClient::Message.new
    message.msg_content=MSG_CONTENT
    @payload.audience=audience
    @payload.platform=platform
    @payload.message=message
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end

  def testsendMessageContentAndTitle
  @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    message=JPushApiRubyClient::Message.new
    message.msg_content=MSG_CONTENT
    message.content_type="content type"
    message.title="message title"
    @payload.audience=audience
    @payload.platform=platform
    @payload.message=message
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end

  def testsendMessageContentAndExtras
  @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    message=JPushApiRubyClient::Message.new
    message.msg_content=MSG_CONTENT
     array={};
    array['key1']='value1'
    array['key2']='value2'
    array['key3']='value3'
    message.extras=array
    @payload.audience=audience
    @payload.platform=platform
    @payload.message=message
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end

end

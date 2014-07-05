require 'JPush'

require './BaseRemoteTests.rb';

require 'test/unit'

class MessageTests < Test::Unit::TestCase
  def setup
    @client=JPush::JPushClient.new(AppKey, MasterSecret);
  end

  def testsendMessageContentOnly
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    message=JPush::Message.new
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
  @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    message=JPush::Message.new
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
  @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    message=JPush::Message.new
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

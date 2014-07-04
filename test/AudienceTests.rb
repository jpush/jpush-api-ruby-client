require 'jpush_api_ruby_client'

require './BaseRemoteTests.rb';

require 'test/unit'
class AudienceTests <Test::Unit::TestCase
    def setup
    @client=JPushApiRubyClient::JPushClient.new(AppKey, MasterSecret);
  end
  
  def testsendByTag
    @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag=TAG1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAnd
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag_and=TAG1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByAlias
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience._alias=ALIAS1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByRegistrationID
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.registration_id=REGISTRATION_ID1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagMore
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag=TAG2
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAndMore
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag_and=TagAndMore
    puts audience.toJSON
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAndMore_fail
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag_and=TAG2
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByAliasMore
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience._alias=ALIAS2
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByRegistrationIDMore
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.registration_id=REGISTRATION_ID2
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAlias
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag=TAG_ALL
    audience._alias=ALIAS1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagRegistrationID
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.registration_id=REGISTRATION_ID1
    audience.tag=TAG_ALL
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagRegistrationID_0
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.registration_id=REGISTRATION_ID1
    audience.tag=TAG_NO
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAlias_0
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag=TAG3
    audience._alias=ALIAS1
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendByTagAlias_0_2
        @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    audience=JPushApiRubyClient::Audience.new
    audience.tag=TAG_ALL
    audience._alias=ALIAS_NO
    notification.alert='alert';
    @payload.platform=platform
    @payload.notification=notification
    @payload.audience=audience
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
end

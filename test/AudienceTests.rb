require 'JPush'

require './BaseRemoteTests.rb';

require 'test/unit'
class AudienceTests <Test::Unit::TestCase
    def setup
    @client=JPush::JPushClient.new(AppKey, MasterSecret);
  end
  
  def testsendByTag
    @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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
        @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    audience=JPush::Audience.new
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

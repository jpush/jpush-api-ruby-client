require 'jpush'
require 'test/unit'

class PushPayLoadTest <Test::Unit::TestCase
  def setup
    @payload=JPush::PushPayload.new
  end

  def testIllegal_OnlyPlatform
    @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    @payload.platform=platform
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testIllegal_OnlyAudience
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    @payload.platform=audience
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testIllegal_PlatformAudience
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    @payload.audience=audience
    platform=JPush::Platform.all
    @payload.platform=platform
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testIllegal_NoAudience
    @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    @payload.platform=platform
    notification=JPush::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testIllegal_NoPlatform
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    @payload.audience=audience
    notification=JPush::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testNotification
    @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    @payload.platform=platform
    audience=JPush::Audience.all
    @payload.audience=audience
    notification=JPush::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    assert_not_nil(@payload.check,"payload formate error")
  end

  def testMessage
    @payload=JPush::PushPayload.new
    platform=JPush::Platform.all
    @payload.platform=platform
    audience=JPush::Audience.all
    @payload.audience=audience
    message=JPush::Message.new;
    message.msg_content = "message content test";
    message.title = "message title test";
    message.content_type = "message content type test";
    message.extras = {"key1"=>"value1", "key2"=>"value2"};
    @payload.message=message
    assert_not_nil(@payload.check,"payload formate error")
  end
end

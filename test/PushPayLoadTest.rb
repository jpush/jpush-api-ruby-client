require 'jpush_api_ruby_client'

require 'test/unit'

class PushPayLoadTest <Test::Unit::TestCase
  def setup
    @payload=JPushApiRubyClient::PushPayload.new
  end

  def testIllegal_OnlyPlatform
    @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    @payload.platform=platform
    @payload.check
  end

  def testIllegal_OnlyAudience
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    @payload.platform=audience
    @payload.check
  end

  def testIllegal_PlatformAudience
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    @payload.audience=audience
    platform=JPushApiRubyClient::Platform.all
    @payload.platform=platform
    @payload.check
  end

  def testIllegal_NoAudience
    @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    @payload.platform=platform
    notification=JPushApiRubyClient::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    @payload.check
  end

  def testIllegal_NoPlatform
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    @payload.audience=audience
    notification=JPushApiRubyClient::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    @payload.check
  end

  def testNotification
    @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    @payload.platform=platform
    audience=JPushApiRubyClient::Audience.all
    @payload.audience=audience
    notification=JPushApiRubyClient::Notification.new;
    notification.alert='alert'
    @payload.notification=notification
    @payload.check
  end

  def testMessage
    @payload=JPushApiRubyClient::PushPayload.new
    platform=JPushApiRubyClient::Platform.all
    @payload.platform=platform
    audience=JPushApiRubyClient::Audience.all
    @payload.audience=audience
    message=JPushApiRubyClient::Message.new;
    message.msg_content = "message content test";
    message.title = "message title test";
    message.content_type = "message content type test";
    message.extras = {"key1"=>"value1", "key2"=>"value2"};
    @payload.message=message
    @payload.check
  end
end

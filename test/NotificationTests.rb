require 'jpush_api_ruby_client'

require './BaseRemoteTests.rb';

require 'test/unit'
class NotificationTests < Test::Unit::TestCase
  def setup
    @client=JPushApiRubyClient::JPushClient.new(AppKey, MasterSecret);
  end
  
  def testsendNotification_android_title
     @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    android= JPushApiRubyClient::AndroidNotification.new
    android.alert='alert'
    android.title='title'
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end
  
  def testsendNotification_android_buildId
         @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    android= JPushApiRubyClient::AndroidNotification.new
    android.alert='alert'
    android.builder_id=100
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end
  
  def testsendNotification_android_extras
         @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    android= JPushApiRubyClient::AndroidNotification.new
    android.alert='alert'
      array={};
    array['key1']='value1'
    array['key2']='value2'
    array['key3']='value3'
    android.extras=array.to_json
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end
  

end

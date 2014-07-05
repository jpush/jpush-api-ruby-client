require 'jpush_api_ruby_client'

require './BaseRemoteTests.rb';

require 'test/unit'
class NotificationTests < Test::Unit::TestCase
  def setup
    @client=JPush::JPushClient.new(AppKey, MasterSecret);
  end
  
  def testsendNotification_android_title
     @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    android= JPush::AndroidNotification.new
    android.alert='alert'
    android.title='title'
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendNotification_android_buildId
         @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    android= JPush::AndroidNotification.new
    android.alert='alert'
    android.builder_id=100
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  
  def testsendNotification_android_extras
         @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    android= JPush::AndroidNotification.new
    android.alert='alert'
      array={};
    array['key1']='value1'
    array['key2']='value2'
    array['key3']='value3'
    android.extras=array
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end
  

end

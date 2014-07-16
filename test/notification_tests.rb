require 'jpush'

require './base_remote_tests.rb'

require 'test/unit'
class NotificationTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testsendNotification_android_title
    @payload = JPush::PushPayload.build(
      audience: JPush::Audience.all,
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        android:  JPush::AndroidNotification.build(
          alert: 'alert',
          title: 'title')))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendNotification_android_buildId
    @payload = JPush::PushPayload.build(
      audience: JPush::Audience.all,
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        android:  JPush::AndroidNotification.build(
          alert: 'alert',
          builder_id: 100)))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendNotification_android_extras
    array = {}
    array['key1'] = 'value1'
    array['key2'] = 'value2'
    array['key3'] = 'value3'
    @payload = JPush::PushPayload.build(
      audience: JPush::Audience.all,
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        android:  JPush::AndroidNotification.build(
          alert: 'alert',
          extras: array)))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  

end

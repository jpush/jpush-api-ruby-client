require 'JPush'
require './BaseRemoteTests.rb';

require 'test/unit'

class AlertOverrideTests < Test::Unit::TestCase
  def setup
    @client=JPush::JPushClient.new(AppKey, MasterSecret);
  end

  def testsendAlert_all
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    notification.alert='alert';
    ios=JPush::IOSNotification.new
    ios.alert='ios alert';
    android= JPush::AndroidNotification.new
    android.alert='android alert';
    winphone=JPush::WinphoneNotification.new
    winphone.alert='winphone alert';
    notification.ios=ios
    notification.android=android
    notification.winphone=winphone
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=res=@client.sendPush(@payload)
    assert_not_nil(res['sendno'], message="")
    puts res
  end

  def testsendAlert_android
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    notification.alert='alert';
    android= JPush::AndroidNotification.new
    android.alert='android alert';
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)

    assert_not_nil(hash['sendno'], message="")
  end

  def testsendAlert_ios
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    notification.alert='alert';
    ios=JPush::IOSNotification.new
    ios.alert='ios alert';
    notification.ios=ios
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end

  def testsendAlert_wp
    @payload=JPush::PushPayload.new
    audience=JPush::Audience.all
    platform=JPush::Platform.all
    notification=JPush::Notification.new
    notification.alert='alert';
    winphone=JPush::WinphoneNotification.new
    winphone.alert='winphone alert';
    notification.winphone=winphone
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    res=@client.sendPush(@payload)
    hash=JSON.parse(res)
    assert_not_nil(hash['sendno'], message="")
  end

end

require 'jpush_api_ruby_client'
require './BaseRemoteTests.rb';

require 'test/unit'

class AlertOverrideTests < Test::Unit::TestCase
  def setup
    @client=JPushApiRubyClient::JPushClient.new(AppKey, MasterSecret);
  end



  def testsendAlert_all
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    notification.alert='alert';
    ios=JPushApiRubyClient::IOSNotification.new
    ios.alert='ios alert';
    android= JPushApiRubyClient::AndroidNotification.new
    android.alert='android alert';
    winphone=JPushApiRubyClient::WinphoneNotification.new
    winphone.alert='winphone alert';
    notification.ios=ios
    notification.android=android
    notification.winphone=winphone
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end

  def testsendAlert_android
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    notification.alert='alert';
    android= JPushApiRubyClient::AndroidNotification.new
    android.alert='android alert';
    notification.android=android
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end

  def testsendAlert_ios
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    notification.alert='alert';
    ios=JPushApiRubyClient::IOSNotification.new
    ios.alert='ios alert';
    notification.ios=ios
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end

  def testsendAlert_wp
    @payload=JPushApiRubyClient::PushPayload.new
    audience=JPushApiRubyClient::Audience.all
    platform=JPushApiRubyClient::Platform.all
    notification=JPushApiRubyClient::Notification.new
    notification.alert='alert';
    winphone=JPushApiRubyClient::WinphoneNotification.new
    winphone.alert='winphone alert';
    notification.winphone=winphone
    @payload.audience=audience
    @payload.platform=platform
    @payload.notification=notification
    @payload.check
    @client.sendPush(@payload)
  end

end

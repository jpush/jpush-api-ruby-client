require 'jpush'
path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')
require 'test/unit'

class AlertOverrideTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end

  def testsendAlert_all
    @payload = JPush::PushPayload.build(
      :audience=>JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
        :ios=> JPush::IOSNotification.build(
          :alert=> 'ios alert'),
        :android=> JPush::AndroidNotification.build(
          :alert=> 'android alert'),
         :winphone=> JPush::WinphoneNotification.build(
           :alert=> 'winphone alert')))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "response error")
  end

  def testsendAlert_android
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
        :android=> JPush::AndroidNotification.build(
          :alert=> 'android alert')))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "response error")
  end

  def testsendAlert_ios
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
        :ios=> JPush::IOSNotification.build(
          :alert=> 'ios alert')))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "response error")
  end

  def testsendAlert_wp
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
         :winphone=> JPush::WinphoneNotification.build(
           :alert=> 'winphone alert')))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "response error")
  end
  
  def testValidate
    @payload = JPush::PushPayload.build(
      :audience=>JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
        :ios=> JPush::IOSNotification.build(
          :alert=> 'ios alert'),
        :android=> JPush::AndroidNotification.build(
          :alert=> 'android alert'),
         :winphone=> JPush::WinphoneNotification.build(
           :alert=> 'winphone alert')))
    res = @client.validate(@payload)
    assert(res.isok, message = "response error")
  end
end

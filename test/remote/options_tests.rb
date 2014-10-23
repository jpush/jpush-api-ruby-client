require 'jpush'

path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')
require 'test/unit'

class OptionsTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end

  def testBigPushDuration
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :options=> JPush::Options.build(
      :big_push_duration=> 10),
      :notification=> JPush::Notification.build(
        :alert=> 'alert',
        :ios=> JPush::IOSNotification.build(
          :alert=> 'ios alert'),
        :android=> JPush::AndroidNotification.build(
          :alert=> 'android alert'),
         :winphone=> JPush::WinphoneNotification.build(
           :alert=> 'winphone alert')))
    res = @client.sendPush(@payload)
    puts res.toJSON
  end
end
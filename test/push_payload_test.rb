require 'jpush'
require 'test/unit'

class PushPayLoadTest <Test::Unit::TestCase
  def setup
    @payload = JPush::PushPayload.new
  end

  def testIllegal_OnlyPlatform
   assert_raises(ArgumentError, message = "ArgumentError") {
     @payload = JPush::PushPayload.build(
      :platform=> JPush::Platform.all)
   }
  end

  def testIllegal_OnlyAudience
    assert_raises(ArgumentError, message = "ArgumentError") {
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all)
    }
  end

  def testIllegal_PlatformAudience
    assert_raises(ArgumentError, message = "ArgumentError") {
      @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all)
    }
  end

  def testIllegal_NoAudience
    assert_raises(ArgumentError, message = "ArgumentError") {
      @payload = JPush::PushPayload.build(
      :platform=> JPush::Platform.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert'))
    }
  end

  def testIllegal_NoPlatform
    assert_raises(ArgumentError, message = "ArgumentError") {
      @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert'))
    }
  end

  def testNotification
    @payload = JPush::PushPayload.build(
      :platform=> JPush::Platform.all,
      :audience=> JPush::Audience.all,
      :notification=> JPush::Notification.build(
        :alert=> 'alert'))
    
  end

  def testMessage
    @payload = JPush::PushPayload.build(
      :platform=> JPush::Platform.all,
      :audience=> JPush::Audience.all,
      :message=> JPush::Message.build(
        :msg_content=>  "message content test",
        :title=> "message title test",
        :content_type=> "message content type test",
        :extras=> {"key1" => "value1", "key2" => "value2"}))      
  end
end

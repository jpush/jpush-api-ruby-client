require 'jpush'

path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')

require 'test/unit'

class MessageTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end

  def testsendMessageContentOnly
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :message=> JPush::Message.build(
        :msg_content=> MSG_CONTENT))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end

  def testsendMessageContentAndTitle
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :message=> JPush::Message.build(
        :msg_content=> MSG_CONTENT,
        :content_type=> "content type",
        :title=> "message title"))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end

  def testsendMessageContentAndExtras
    array = {}
    array['key1'] = 'value1'
    array['key2'] = 'value2'
    array['key3'] = 'value3'
    @payload = JPush::PushPayload.build(
      :audience=> JPush::Audience.all,
      :platform=> JPush::Platform.all,
      :message=> JPush::Message.build(
        :msg_content=> MSG_CONTENT,
        :extras=> array))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end

end

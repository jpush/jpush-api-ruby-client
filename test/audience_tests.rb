require 'jpush'

require './base_remote_tests.rb'

require 'test/unit'
class AudienceTests < Test::Unit::TestCase
    def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testsendByTag
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        tag: TAG1))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAnd
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        tag_and: TAG1))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByAlias
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        _alias: ALIAS1))
    res = @client.sendPush(@payload)
    assert_not_nil(res.isok, message = "")
  end
  
  def testsendByRegistrationID
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        registration_id: REGISTRATION_ID1))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagMore
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
      tag: TAG2))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAndMore
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
       tag_and: TagAndMore))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAndMore_fail
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        tag_and: TAG2))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByAliasMore
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        _alias: ALIAS2))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByRegistrationIDMore
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        registration_id: REGISTRATION_ID2))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAlias
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
      tag: TAG_ALL,
      _alias: ALIAS1))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagRegistrationID
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        registration_id: REGISTRATION_ID1,
        tag: TAG_ALL))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagRegistrationID_0
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        registration_id: REGISTRATION_ID1,
        tag: TAG_NO))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAlias_0
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        tag: TAG3,
        _alias: ALIAS1))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
  
  def testsendByTagAlias_0_2
    @payload = JPush::PushPayload.build(
      platform: JPush::Platform.all,
      notification: JPush::Notification.build(
        alert: 'alert'),
      audience: JPush::Audience.build(
        tag: TAG_ALL,
        _alias: ALIAS_NO))
    res = @client.sendPush(@payload)
    assert(res.isok, message = "")
  end
end

require 'jpush'

master_secret = '2b38ce69b1de2a7fa95706ea'
app_key = 'dd1066407b044738b6479275'
client = JPush::JPushClient.new(app_key, master_secret)

logger = Logger.new(STDOUT)
#send broadcast
payload1 = JPush::PushPayload.build(
 platform: JPush::Platform.all,
 audience: JPush::Audience.all,
 notification: JPush::Notification.build(
   alert: 'alert meassage')
)
result = client.sendPush(payload1)
logger.debug("Got result  " +  result.toJSON)
 
#send winphone
payload1 = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  audience: JPush::Audience.all,
  notification: JPush::Notification.build(
    alert: 'alert meassage',
    winphone: JPush::WinphoneNotification.build(
      alert: "winphone notification alert test",
      title: "winphone notification title test",
      _open_page: "/friends.xaml",
      extras: {"key1" => "value1", "key2" => "value2"})))
result = client.sendPush(payload1)
logger.debug("Got result  " +  result.toJSON)

#send android WithExtrasMessage
payload1 = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  audience: JPush::Audience.all,
  notification: JPush::Notification.build(
    alert: 'alert meassage',
    android: JPush::AndroidNotification.build(
      alert: "android notification alert test",
      title: "android notification title test",
      builder_id: 1,
      extras: {"key1" => "value1", "key2" => "value2"})),
  message: JPush::Message.build(
    msg_content: "message content test",
    title: "message title test",
    content_type: "message content type test",
    extras: {"key1" => "value1", "key2" => "value2"})
)
result = client.sendPush(payload1)
logger.debug("Got result  " +  result.toJSON)

#send ios WithExtrasMessageANDoptions
payload1 = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  audience: JPush::Audience.all,#audience: JPush::Audience.build{ _alias : "your alias"}
  notification: JPush::Notification.build(
    alert: 'alert meassage',
    ios: JPush::IOSNotification.build(
      alert: "ios notification alert test",
      title: "ios notification title test",
      badge: 1,
      sound: "happy",
      extras: {"key1" => "value1", "key2" => "value2"})),
  message: JPush::Message.build(
    msg_content: "message content test",
    title: "message title test",
    content_type: "message content type test",
    extras: {"key1" => "value1", "key2" => "value2"}),
    options:JPush::Options.build(
    sendno: 1,
    apns_production: true))
result = client.sendPush(payload1)
logger.debug("Got result  " +  result.toJSON)

#sendByTag
payload = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  notification: JPush::Notification.build(
    alert: 'alert'),
  audience: JPush::Audience.build(
    tag: ["tag1"]))
res = client.sendPush(payload)
logger.debug("Got result  " +  res.toJSON)
#sendByTagAnd
payload = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  notification: JPush::Notification.build(
    alert: 'alert'),
  audience: JPush::Audience.build(
    tag_and: ["tag1"]))
res = client.sendPush(payload)
logger.debug("Got result  " +  res.toJSON)
#sendByAlias
payload = JPush::PushPayload.build(
  platform: JPush::Platform.all,
  notification: JPush::Notification.build(
    alert: 'alert'),
  audience: JPush::Audience.build(
    _alias: ["alias1"]))
res = client.sendPush(payload)
logger.debug("Got result  " +  res.toJSON)

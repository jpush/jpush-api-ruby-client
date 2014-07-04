require 'jpush_api_ruby_client'



master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPushApiRubyClient::JPushClient.new(app_key, master_secret);

logger = Logger.new(STDOUT);
#send broadcast
payload1 =JPushApiRubyClient::PushPayload.new(
platform: JPushApiRubyClient::Platform.all,
audience: JPushApiRubyClient::Audience.all,
notification: JPushApiRubyClient::Notification.new(alert: 'alert meassage')
).check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
 
 #send winphone
 payload1 =JPushApiRubyClient::PushPayload.new(
platform: JPushApiRubyClient::Platform.all,
audience: JPushApiRubyClient::Audience.all,
notification: JPushApiRubyClient::Notification.new(alert: 'alert meassage',
  winphone: JPushApiRubyClient::WinphoneNotification.new(alert: "winphone notification alert test",
    title: "winphone notification title test",
    _open_page: "/friends.xaml",
    extras: {"key1"=>"value1", "key2"=>"value2"}))
).check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
 #send android WithExtrasMessage
 payload1 =JPushApiRubyClient::PushPayload.new(
platform: JPushApiRubyClient::Platform.all,
audience: JPushApiRubyClient::Audience.all,
notification: JPushApiRubyClient::Notification.new(alert: 'alert meassage',
  android: JPushApiRubyClient::AndroidNotification.new(alert: "android notification alert test",
    title: "android notification title test",
    builder_id: 1,
    extras: {"key1"=>"value1", "key2"=>"value2"})),
message: JPushApiRubyClient::Message.new(msg_content: "message content test",
  title: "message title test",
  content_type: "message content type test",
  extras: {"key1"=>"value1", "key2"=>"value2"})
).check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
 #send ios WithExtrasMessageANDoptions
  payload1 =JPushApiRubyClient::PushPayload.new(
platform: JPushApiRubyClient::Platform.all,
audience: JPushApiRubyClient::Audience.all,
notification: JPushApiRubyClient::Notification.new(alert: 'alert meassage',
  android: JPushApiRubyClient::IOSNotification.new(alert: "android notification alert test",
    title: "android notification title test",
    badge: 1,
    sound: "happy",
    extras: {"key1"=>"value1", "key2"=>"value2"})),
message: JPushApiRubyClient::Message.new(msg_content: "message content test",
  title: "message title test",
  content_type: "message content type test",
  extras: {"key1"=>"value1", "key2"=>"value2"}),
options:JPushApiRubyClient::Options.new(sendno: 1,
  apns_production: true)
).check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
 

require 'jpush'

master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPushApiRubyClient::JPushClient.new(app_key, master_secret);

notification=JPushApiRubyClient::Notification.new;
ios=JPushApiRubyClient::IOSNotification.new;
android= JPushApiRubyClient::AndroidNotification.new;
winphone=JPushApiRubyClient::WinphoneNotification.new;
platform=JPushApiRubyClient::Platform.new;
audience=JPushApiRubyClient::Audience.new;
message=JPushApiRubyClient::Message.new;
options=JPushApiRubyClient::Options.new;

platform.ios=true;
platform.winphone=true;
platform.android=true

#set message params
message.msg_content = "message content test";
message.title = "message title test";
message.content_type = "message content type test";
message.extras = {"key1"=>"value1", "key2"=>"value2"};

#set options params
options.sendno = 1;
options.apns_production = true;
#options.override_msg_id = 2;
options.time_to_live = 60;
#set audience params
tag=['tag1','tag2'];
tag_and=["tag3","tag4"];
_alias=["alias1","alias2"]
registration_id=["id1","id2"];
audience.tag = tag;
audience.tag_and = tag_and;
audience._alias = _alias;
audience.registration_id = registration_id;

#set notification params
ios.alert = "ios notification alert test";
ios.sound = "happy";
ios.badge = 1;
ios.extras = {"key1"=>"value1", "key2"=>"value2"};
ios.content_available = nil;

android.alert = "android notification alert test";
android.title = "android notification title test";
android.builder_id = 1;
android.extras = {"key1"=>"value1", "key2"=>"value2"};

winphone.alert = "winphone notification alert test";
winphone.title = "winphone notification title test";
winphone._open_page = "/friends.xaml";
winphone.extras = {"key1"=>"value1", "key2"=>"value2"};


logger = Logger.new(STDOUT);
#send broadcast
payload1 =JPushApiRubyClient::PushPayload.new;
notification.alert = "alert message";
payload1.notification = notification;
payload1.platform=platform;
payload1.audience=audience;
payload1.check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
#send winphone
payload1 =JPushApiRubyClient::PushPayload.new;
notification.winphone=winphone
payload1.notification=notification
payload1.platform=platform;
payload1.audience=audience;
payload1.check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
#send android WithExtrasMessage
payload1 =JPushApiRubyClient::PushPayload.new;
notification.android=android
payload1.notification=notification
payload1.platform=platform;
payload1.audience=audience;
payload1.message=message
payload1.check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)
#send ios WithExtrasMessageANDoptions
payload1 =JPushApiRubyClient::PushPayload.new;
notification.ios=ios
payload1.notification=notification
payload1.platform=platform;
payload1.audience=audience;
payload1.message=message
payload1.options=options
payload1.check
result = client.sendPush(payload1);
 logger.debug("Got result - " + result)

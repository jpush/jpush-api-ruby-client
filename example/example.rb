require 'jpush_api_ruby_client'
master_secret='d94f733358cca97b18b2cb98';
app_key='47a3ddda34b2602fa9e17c01';
tag='tag1,tag2';
tag_and="tag3,tag4";
_alias="alias1,alias2";
registration_id="id1,id2";
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

options.sendno=1
options.apns_production=true;
options.override_msg_id=2;
options.time_to_live=60;

#set message params
message.msg_content = "message content test";
message.title = "message title test";
message.content_type = "message content type test";
message.extras = {"key1"=>"value1", "key2"=>"value2"};

#set options params
options.sendno = 1;
options.apns_production = true;
options.override_msg_id = 2;
options.time_to_live = 60;

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

notification.alert = "notification alert test";
notification.android = android;
notification.ios = ios;
notification.winphone =  winphone;

payload1 =JPushApiRubyClient::PushPayload.new;
notification1 =JPushApiRubyClient::Notification.new;
notification1.alert = "alert message";
payload1.notification = notification;
puts payload1.toJSON;
result1 = client.sendPush(payload1);
puts result1;

#puts  File.expand_path('../jpush_api_ruby_client/version', __FILE__)
module JPush

  #V3
  autoload :JPushClient,'Jpush/jpush_client.rb'
  autoload :NativeHttpClient,'Jpush/http_client'
  autoload :PushClient,'Jpush/push_client'
  autoload :ReportClient,'Jpush/report_client'
  autoload :Audience,'Jpush/model/audience'
  autoload :Message,'Jpush/model/message'
  autoload :Options,'Jpush/model/options'
  autoload :Platform,'Jpush/model/platform'
  autoload :PushPayload,'Jpush/model/push_payload'
  autoload :AndroidNotification,'Jpush/model/notification/android_notification'
  autoload :IOSNotification,'Jpush/model/notification/ios_notification'
  autoload :WinphoneNotification,'Jpush/model/notification/winphone_notification'
  autoload :Notification,'Jpush/model/notification/notification'
end

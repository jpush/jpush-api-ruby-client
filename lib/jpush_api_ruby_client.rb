require File.expand_path('../jpush_api_ruby_client/version', __FILE__)
#puts  File.expand_path('../jpush_api_ruby_client/version', __FILE__)
module JPushApiRubyClient
  autoload :Client, 'jpush_api_ruby_client/client'
  autoload :ReceiverType, 'jpush_api_ruby_client/receiver_type'
  autoload :PlatformType, 'jpush_api_ruby_client/platform_type'
  autoload :MsgType, 'jpush_api_ruby_client/msg_type'
  #V3
  autoload :JPushClient,'Jpush/JPushClient'
  autoload :NativeHttpClient,'Jpush/NativeHttpClient'
  autoload :PushClient,'Jpush/PushClient'
  autoload :ReportClient,'Jpush/ReportClient'
  autoload :Audience,'Jpush/model/Audience'
  autoload :Message,'Jpush/model/Message'
  autoload :Options,'Jpush/model/Options'
  autoload :Platform,'Jpush/model/Platform'
  autoload :PushPayload,'Jpush/model/PushPayload'
  autoload :AndroidNotification,'Jpush/model/notification/AndroidNotification'
  autoload :IOSNotification,'Jpush/model/notification/IOSNotification'
  autoload :WinphoneNotification,'Jpush/model/notification/WinphoneNotification'
  autoload :Notification,'Jpush/model/notification/Notification'
end

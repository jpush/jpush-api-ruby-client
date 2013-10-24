require File.expand_path('../jpush_api_ruby_client/version', __FILE__)
module JPushApiRubyClient
  autoload :Client, 'jpush_api_ruby_client/client'
  autoload :ReceiverType, 'jpush_api_ruby_client/receiver_type'
  autoload :PlatformType, 'jpush_api_ruby_client/platform_type'
  autoload :MsgType, 'jpush_api_ruby_client/msg_type'

end
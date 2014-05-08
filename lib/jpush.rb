require File.expand_path('../jpush/common/version', __FILE__)
module JPush
  autoload :JPushClient, 'jpush/jpush_client'
  autoload :ReceiverType, 'jpush/common/receiver_type'
  autoload :PlatformType, 'jpush/common/platform_type'
  autoload :MsgType, 'jpush/common/msg_type'
  autoload :ValidateRequestParams, 'jpush/common/validate_request_params'
  autoload :RestUtils, 'jpush/utils/rest_utils'
  autoload :Digest, 'digest'

end
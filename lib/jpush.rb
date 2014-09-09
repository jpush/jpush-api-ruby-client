
module JPush

  #V3
  autoload :JPushClient,'jpush/jpush_client.rb'
  autoload :NativeHttpClient,'jpush/http_client'
  autoload :PushClient,'jpush/push_client'
  autoload :ReportClient,'jpush/report_client'
  autoload :Audience,'jpush/model/audience'
  autoload :Message,'jpush/model/message'
  autoload :Options,'jpush/model/options'
  autoload :Platform,'jpush/model/platform'
  autoload :PushPayload,'jpush/model/push_payload'
  autoload :AndroidNotification,'jpush/model/notification/android_notification'
  autoload :IOSNotification,'jpush/model/notification/ios_notification'
  autoload :WinphoneNotification,'jpush/model/notification/winphone_notification'
  autoload :Notification,'jpush/model/notification/notification'
  autoload :PushResult, 'jpush/model/push_result'
  autoload :ReceivedsResult, 'jpush/model/receiveds_result'
  autoload :DeviceClient, 'jpush/device_client'
  autoload :TagManager, 'jpush/model/tag_manager'
  autoload :TagAlias, 'jpush/model/tag_alias'
  autoload :TagAliasResult, 'jpush/model/tag_alias_result'
  autoload :ExistResult, 'jpush/model/exist_result'
  autoload :TagListResult, 'jpush/model/tag_list_result'
  autoload :AliasUidsResult, 'jpush/model/alias_uids_result'
  autoload :ApiConnectionException, 'jpush/api_connection_exception'
end

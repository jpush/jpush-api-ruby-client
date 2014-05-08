require 'jpush'

class JpushClientExample

  app_key = 'dd1066407b044738b6479275' #required, app_key
  master_secret = '2b38ce69b1de2a7fa95706ea' #required, app_masterSecret
  TITLE = 'Test from JPush Ruby API example'
  CONTENT = 'Test Test'
  REGISTRATION_ID = '0900e8d85ef'
  TAG = 'tag_api'
  # 保存离线的时长。秒为单位。max support 10 day（864000秒）。
  # 0 表示该消息不保存离线。即：用户在线马上发出，当前不在线用户将不会收到此消息。
  # 此参数不设置则表示默认，默认为保存1天的离线消息（86400秒）。
  #
  # Default Value Tips
  # time_to_live = 60 * 60 * 24
  # platform = JPush::PlatformType::ALL
  # apnsProduction = false
  #
  # Example1: send to all platform and use default value send
  # jpush_client = JPush::JPushClient.new(app_key, master_secret)
  #
  # Example2: only send to single platform
  #
  # jpush_client = JPush::Client.new(app_key, master_secret, 'platform' => JPush::PlatformType::ANDROID);
  #
  # Example3: send to apns production
  # jpush_client =JPush::Client.new(app_key, master_secret, 'time_to_live' => time_to_live, 'platform' => JPush::PlatformType::ANDROID);
  #
  #Example5: 使用缺省值发送，默认 time_to_live 为保存1天的离线消息 ，发送给IOS,android两个平台
  # jpush_client = JPush::Client.new(app_key, master_secret)
  #

  jpush_client = JPush::JPushClient.new(app_key, master_secret, 'platform' => JPush::PlatformType::IOS, 'apnsProduction' => true)

  jpush_client.enable_ssl(false)
  #enable https，default false

  message_result = jpush_client.send_notification(CONTENT,{},{})
  puts message_result
  message_id = message_result['message_id']
  notification_params = {'receiver_type' => JPush::ReceiverType::REGISTRATION_ID,
                         'receiver_value' => REGISTRATION_ID}

  puts message_result = jpush_client.send_notification('msg_content', notification_params,{})

  puts message_result = jpush_client.send_custom_message('msg_title','msg_content',{},{})
=begin
  带上可选参数调用  opts参数可包含 builder_id 、extras 、override_msg_id
=end
  #puts send_result = jpush_client.send_notification_with_appkey(send_no,
  #                                                              msg_title,
  #                                                              msg_content,
  #                                                              'builder_id' => 0,
  #                                                              'extras' => {'key1'=> 'value1','key2'=>'value2'})
  puts query_result = jpush_client.get_report_receiveds(message_id)

  #msg_content = '根据 tag 发送通知'
  #puts send_result = jpush_client.send_notification_with_tag(send_no, '这里输入你的tag', msg_title, msg_content)

  #msg_content = '根据 alias 发送通知'
  #puts send_result = jpush_client.send_notification_with_alias(send_no, '这里输入你的alias', msg_title, msg_content)

  #msg_content = '根据 imei 发送通知'
  #puts send_result = jpush_client.send_notification_with_imei(send_no, '这里输入你的imei', msg_title, msg_content)


  #msg_content = '根据 appkey 发送自定义消息'
  #puts send_result = jpush_client.send_message_with_appkey(send_no, msg_title, msg_content)
=begin
  带上可选参数调用  opts参数可包含 extras 、override_msg_id

  puts send_result = jpush_client.send_message_with_appkey(send_no,
                                                                msg_title,
                                                                msg_content,
                                                                'extras' => {'key1'=> 'value1','key2'=>'value2'},
                                                               )
=end

  #msg_content = '根据 tag 发送自定义消息'
  #puts send_result = jpush_client.send_message_with_alias(send_no, '这里输入你的tag', msg_title, msg_content)

  #msg_content = '根据 alias 发送自定义消息'
  #puts send_result = jpush_client.send_message_with_tag(send_no, '这里输入你的alias', msg_title, msg_content)

  #msg_content = '根据 imei 发送自定义消息'
  #puts send_result = jpush_client.send_message_with_imei(send_no, '这里输入你的imei', msg_title, msg_content)


end


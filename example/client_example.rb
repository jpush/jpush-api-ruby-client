require 'jpush_api_ruby_client'

class ClientExample

  app_key = '466f7032ac604e02fb7bda89' #必填，例如466f7032ac604e02fb7bda89
  master_secret = '57c45646c772983fede7c455' #必填，每个应用都对应一个masterSecret

  # 保存离线的时长。秒为单位。最多支持10天（864000秒）。
  # 0 表示该消息不保存离线。即：用户在线马上发出，当前不在线用户将不会收到此消息。
  # 此参数不设置则表示默认，默认为保存1天的离线消息（86400秒）。

  time_to_live = 60 * 60 * 24

  #
  # Example1: 初始化,默认发送给android和ios，同时设置离线消息存活时间
  # jpush_client = JPushApiRubyClient::Client.new(app_key, masterSecret, 'time_to_live' => time_to_live)
  #
  # Example2: 只发送给android
  # jpush_client = JPushApiRubyClient::Client.new(app_key, master_secret, 'platform' => JPushApiRubyClient::PlatformType::ANDROID);
  #
  # Example3: 只发送给IOS
  # jpush_client = JPushApiRubyClient::Client.new(app_key, master_secret, 'platform' => JPushApiRubyClient::PlatformType::IOS);
  #
  # Example4: 只发送给android,同时设置离线消息存活时间
  # jpush_client =JPushApiRubyClient::Client.new(app_key, master_secret, 'time_to_live' => time_to_live, 'platform' => JPushApiRubyClient::PlatformType::ANDROID);
  #
  #Example5: 使用缺省值发送，默认 time_to_live 为保存1天的离线消息 ，发送给IOS,android两个平台
  # jpush_client = JPushApiRubyClient::Client.new(app_key, master_secret)
  #

  jpush_client = JPushApiRubyClient::Client.new(app_key, master_secret,'platform' => JPushApiRubyClient::PlatformType::BOTH)

  #jpush_client.enable_ssl(true) 是否启用https请求，缺省false


  send_no = jpush_client.generate_send_no
  msg_title = 'JPushApiRubyClient实例'

  msg_content = '根据 appkey 发送广播通知'
  puts send_result = jpush_client.send_notification_with_appkey(send_no, msg_title, msg_content)

=begin
  带上可选参数调用  opts参数可包含 builder_id 、extras 、override_msg_id
  puts send_result = jpush_client.send_notification_with_appkey(send_no,
                                                                msg_title,
                                                                msg_content,
                                                                'builder_id' => 0,
                                                                'extras' => {'key1'=> 'value1','key2'=>'value2'},
                                                                'override_msg_id' => '这里输入你上一条消息的msg_id')
=end

  msg_content = '根据 tag 发送通知'
  puts send_result = jpush_client.send_notification_with_tag(send_no, '这里输入你的tag', msg_title, msg_content)

  msg_content = '根据 alias 发送通知'
  puts send_result = jpush_client.send_notification_with_alias(send_no, '这里输入你的alias', msg_title, msg_content)

  msg_content = '根据 imei 发送通知'
  puts send_result = jpush_client.send_notification_with_imei(send_no, '这里输入你的imei', msg_title, msg_content)


  msg_content = '根据 appkey 发送自定义消息'
  puts send_result = jpush_client.send_message_with_appkey(send_no, msg_title, msg_content)
=begin
  带上可选参数调用  opts参数可包含 extras 、override_msg_id
  puts send_result = jpush_client.send_message_with_appkey(send_no,
                                                                msg_title,
                                                                msg_content,
                                                                'extras' => {'key1'=> 'value1','key2'=>'value2'},
                                                                'override_msg_id' => '这里输入你上一条消息的msg_id')
=end

  msg_content = '根据 tag 发送自定义消息'
  puts send_result = jpush_client.send_message_with_alias(send_no, '这里输入你的tag', msg_title, msg_content)

  msg_content = '根据 alias 发送自定义消息'
  puts send_result = jpush_client.send_message_with_tag(send_no, '这里输入你的alias', msg_title, msg_content)

  msg_content = '根据 imei 发送自定义消息'
  puts send_result = jpush_client.send_message_with_imei(send_no, '这里输入你的imei', msg_title, msg_content)


end


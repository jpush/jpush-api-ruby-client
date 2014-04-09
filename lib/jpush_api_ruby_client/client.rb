require 'rest-client'
require 'json'

module JPushApiRubyClient

  # HTTP
  HTTP_JPUSH_API_URL = 'http://api.jpush.cn:8800/v2/push'
  # HTTPS
  HTTPS_JPUSH_API_URL = "https://api.jpush.cn:443/v2/push"

  class Client
    include PlatformType, MsgType, ReceiverType
    attr_accessor :app_key, :master_secret, :https, :time_to_live, :platform, :apns_production

=begin
    * @param [String] app_key
    * @param [String] master_secret
    * @param [Hash] opts  opts可选参数可包含time_to_live、platform
=end
    def initialize(app_key, master_secret, opts ={}, &block)
      @app_key = app_key
      @master_secret = master_secret
      @time_to_live = opts['time_to_live'] || 86400
      @platform = opts['platform'] || PlatformType::BOTH
      @apns_production = opts['apns_production'] || 0
    end

=begin
    * 当前时间戳生成send_no
    * @return [Integer]
=end
    def generate_send_no
      Integer(Time.new)
    end

=begin
    * 是否启用https ssl连接，缺省false
    * @param [Object]  true or false
=end
    def enable_ssl(https = false)
      @https = https
    end

=begin
    * 发送使用 appkey 推送的自定义消息
    * @param [Integer] send_no
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts可选参数包含 extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_message_with_appkey(send_no, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::BROADCAST}
      send_custom_message(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送标签带推送的自定义消息
    * @param [Integer] send_no
    * @param [String] tag
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含  extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_message_with_tag(send_no, tag, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::TAG,
                  :receiver_value => tag}
      send_custom_message(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送带别名推送的自定义消息
    * @param [Integer] send_no
    * @param [String] alias_
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含 extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_message_with_alias(send_no, alias_, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::ALIAS,
                  :receiver_value => alias_}
      send_custom_message(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送带 imei 推送的自定义消息
    * @param [Integer] send_no
    * @param [String] imei
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含 extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_message_with_imei(send_no, imei, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::IMEI,
                  :receiver_value => imei}
      send_custom_message(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送使用 appkey 推送的通知
    * @param [Integer] send_no
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含 builder_id 、extras 、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_notification_with_appkey(send_no, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::BROADCAST,
                  :receiver_value => ''}
      send_notification(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送带标签推送的通知
    * @param [Integer] send_no
    * @param [String] tag
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含 builder_id 、extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_notification_with_tag(send_no, tag, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::TAG,
                  :receiver_value => tag}
      send_notification(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送带别名推送的通知
    * @param [Integer] send_no
    * @param [String] alias_
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含builder_id 、extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_notification_with_alias(send_no, alias_, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::ALIAS,
                  :receiver_value => alias_}
      send_notification(send_no, msg_title, msg_content, receiver, opts)
    end

=begin
    * 发送带IMEI号推送的通知
    * @param [Integer] send_no
    * @param [String] imei
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] opts opts参数可包含 builder_id、extras、override_msg_id
    * @return [Hash] sendno、msg_id、errcode、errmsg
=end
    def send_notification_with_imei(send_no, imei, msg_title, msg_content, opts = {})
      receiver = {:receiver_type => ReceiverType::IMEI,
                  :receiver_value => imei}
      send_notification(send_no, msg_title, msg_content, receiver, opts)
    end

    private

    def send_notification(send_no, msg_title, msg_content, receiver, opts)
      msg_body = {:n_content => msg_content,
                  :n_title => msg_title,
                  :n_builder_id => opts['builder_id'] || 0
      }
      msg_body[:n_extras] = opts['extras'] if opts.has_key?('extras')

      msg = {:msg_type => MsgType::NOTIFICATION,
             :msg_content => msg_body,
             :platform => platform,
             :time_to_live => time_to_live,
             :apns_production => apns_production
      }
      msg[:override_msg_id] = opts['override_msg_id'] if opts.has_key?('override_msg_id')
      send_message(send_no, msg, receiver)
    end

    def send_custom_message(send_no, msg_title, msg_content, receiver, opts)
      msg_body = {:message => msg_content,
                  :title => msg_title
      }
      msg_body[:extras] = opts['extras'] if opts.has_key?('extras')

      msg = {:msg_type => MsgType::MESSAGE,
             :msg_content => msg_body,
             :platform => platform,
             :time_to_live => time_to_live,
             :apns_production => apns_production
      }
      msg[:override_msg_id] = opts['override_msg_id'] if msg.has_key?('override_msg_id')

      send_message(send_no, msg, receiver)
    end

    # MD5 secret

    def build_verification(send_no, receiver_type, receiver_value, master_secret)
      verification_code = "#{send_no}#{receiver_type}#{receiver_value}#{master_secret}"
      Digest::MD5.hexdigest(verification_code)
    end

    def send_message(send_no, msg, receiver, options={})
      api_url = https == true ? HTTPS_JPUSH_API_URL : HTTP_JPUSH_API_URL
      post_body = {}
      post_body[:app_key] = app_key
      post_body[:sendno] = send_no
      post_body[:receiver_type] = receiver[:receiver_type]
      post_body[:receiver_value] = receiver[:receiver_value] if receiver.has_key?(:receiver_value)

      post_body[:verification_code] = build_verification(send_no,
                                                         receiver[:receiver_type],
                                                         receiver[:receiver_value] || '',
                                                         master_secret)
      post_body[:msg_type] = msg[:msg_type]
      post_body[:msg_content] = JSON.generate(msg[:msg_content])
      post_body[:platform] = msg[:platform]
      post_body[:apns_production] = msg[:apns_production]
      post_body[:time_to_live] = msg[:time_to_live]
      post_body[:override_msg_id] = msg[:override_msg_id] if msg.has_key?(:override_msg_id)

      post_body.merge!(options)
      post_jpush_api(api_url, post_body)
    end

    # POST JPush API
    def post_jpush_api(api_url, post_body)
      response_msg = RestClient.post(
          api_url,
          post_body,
          content_type: "application/x-www-form-urlencoded",
          accept: :json)
      JSON.parse(response_msg)
    end
  end
end
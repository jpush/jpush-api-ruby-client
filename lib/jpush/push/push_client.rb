require 'json'

require File.dirname(__FILE__) + '/message_result'

module JPush

  # HTTP
  HTTP_JPUSH_API_URL = 'http://api.jpush.cn:8800/v2/push'
  # HTTPS
  HTTPS_JPUSH_API_URL = 'https://api.jpush.cn:443/v2/push'

  class PushClient
    attr_accessor :app_key, :master_secret, :https, :time_to_live, :platform, :apnsProduction

=begin
    * @param [String] app_key
    * @param [String] master_secret
    * @param [Integer] time_to_live
    * @param [PlatformType] choose platform, default platform PlatformType::BOTH
    * @param [Boolean] if send to apnsProduction set true, default value false
=end
    def initialize(app_key, master_secret, time_to_live = 86400 ,
                   platform = PlatformType::ALL, apnsProduction = false, &block)
      @app_key = app_key
      @master_secret = master_secret
      @time_to_live = time_to_live
      @platform = platform
      @apnsProduction = apnsProduction
    end

=begin
    * generate send_no from now timestamp
    * @return [Integer]
=end
    def generate_send_no
      Integer(Time.new)
    end

=begin
    *  enable https ssl，default value false
    * @param [Object]  true or false
=end
    def enable_ssl(https = false)
      @https = https
    end



=begin
    * send notification
    * @param [String] notification_content
    * @param [Hash] notification_params
    * @param [Hash] extras
    * @return [MessageResult]
=end
    def send_notification(notification_content, notification_params, extras={})
      msg_body = {:n_content => notification_content,
                  :n_title => notification_params['title'] || '',
                  :n_builder_id => notification_params['builder_id'] || 0
      }
      msg_body[:n_extras] = extras
      msg = {:msg_type => MsgType::NOTIFICATION,
             :msg_content => msg_body,
             :platform => platform,
             :time_to_live => time_to_live,
             :apnsProduction => apnsProduction
      }
      msg[:override_msg_id] = notification_params['override_msg_id'] if notification_params.has_key?('override_msg_id')
      send_no = notification_params['send_no'] || 1
      receiver =  {:receiver_type => notification_params['receiver_type'] || ReceiverType::BROADCAST,
                   :receiver_value => notification_params['receiver_value']|| ''}
      send_message(send_no, msg, receiver)
    end

=begin
    * send custom message
    * @param [String] msg_title
    * @param [String] msg_content
    * @param [Hash] custom_message_params
    * @param [Hash] extras
    * @return [MessageResult]
=end
    def send_custom_message(msg_title, msg_content, custom_message_params, extras={})
      msg_body = {:message => msg_content,
                  :title => msg_title
      }
      msg_body[:extras] = extras

      msg = {:msg_type => MsgType::MESSAGE,
             :msg_content => msg_body,
             :platform => platform,
             :time_to_live => time_to_live,
             :apnsProduction => apnsProduction

      }
      msg[:override_msg_id] = custom_message_params['override_msg_id'] if msg.has_key?('override_msg_id')
      send_no = custom_message_params['send_no'] || 1
      receiver = custom_message_params['receiver'] || {:receiver_type => ReceiverType::BROADCAST,
                                                       :receiver_value => ''}

      send_message(send_no, msg, receiver)
    end

    private

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
      post_body[:apnsProduction] = msg[:apnsProduction]
      post_body[:time_to_live] = msg[:time_to_live]
      post_body[:override_msg_id] = msg[:override_msg_id] if msg.has_key?(:override_msg_id)

      post_body.merge!(options)
      MessageResult.result(RestUtils.post_jpush_api(api_url, post_body))
    end

  end
end

require File.dirname(__FILE__) + '/push/push_client'
require File.dirname(__FILE__) + '/report/report_client'
require File.dirname(__FILE__) + '/common/validate_request_params'

module JPush

  class JPushClient

=begin
    * @param [String] app_key
    * @param [String] master_secret
    * @param [Integer] time_to_live
    * @param [PlatformType] choose platform, default platform PlatformType::BOTH
    * @param [Boolean] if send to apnsProduction set true, default value false
=end
    def initialize(app_key, master_secret, opts ={} &block)
      ValidateRequestParams.checkPushParams( app_key, master_secret)
      platform = opts['platform'] || PlatformType::ALL
      time_to_live = opts['time_to_live'] || 86400
      apnsProduction = opts['apnsProduction'] || false
      if platform.is_a?(Array)
        platform.each do | arr| platform = arr.join(',')
        end
      end
      @push_client = JPush::PushClient.new(app_key, master_secret, time_to_live, platform, apnsProduction)
      @report_client = JPush::ReportClient.new(app_key,master_secret)
    end
    def enable_ssl(https = false)
      @push_client.enable_ssl(https)
    end
    def send_notification(notification_content, notification_params={}, extras={})
      @push_client.send_notification(notification_content, notification_params, extras)
    end
    def send_custom_message(msg_title, msg_content, custom_message_params={}, extras={})
      @push_client.send_custom_message(msg_title, msg_content, custom_message_params, extras)
    end
    def get_report_receiveds(msg_ids)
      @report_client.get_report_receiveds(msg_ids)
    end
  end
end
require 'json'

require File.dirname(__FILE__) + '/receiveds_result'

module JPush

  # HTTPS RECEIVED URL
  HTTPS_JPUSH_API_RECEIVED_URL = 'https://report.jpush.cn/v2/received'

  class ReportClient
    attr_accessor :app_key, :master_secret

=begin
    * @param [String] app_key
    * @param [String] master_secret
=end
    def initialize(app_key, master_secret,&block)
      @app_key = app_key
      @master_secret = master_secret
    end

=begin
    * send custom message
    * @param [String|Array] msg_ids,use [,]separate if it is a string type
    * @return [ReceivedsResult]
=end
    def get_report_receiveds(msg_ids)
      ValidateRequestParams.checkReportParams( msg_ids)
      if msg_ids.is_a?(Array)
        msg_ids.each do | arr| msg_ids = arr.join(',')
        end
      end
      url = URI.parse(HTTPS_JPUSH_API_RECEIVED_URL)
      url.query = "msg_ids=#{msg_ids}"
      headers = {:user => app_key,
                 :password => master_secret
                }
      ReceivedsResult.result(RestUtils.get_jpush_api(url.to_s,headers))
    end
  end
end
require 'jpush/util'

module JPush

  REPORT_URI = "https://report.jpush.cn/v2/received"

  class Report
    include JPush::Util
    attr_reader :app_key, :master_secret

    def initialize app_key, master_secret
      @app_key = app_key.to_s
      @master_secret = master_secret.to_s
    end

    def get_reports msgs = []
      get REPORT_URI, { msg_ids: msgs.join(",") }
    end
  end
end

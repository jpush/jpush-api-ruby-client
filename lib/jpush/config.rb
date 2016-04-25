module JPush
  module Config
    extend self

    DEFAULT_OPTIONS = {
      api_version: 'v3',
      push_api_host: 'https://api.jpush.cn/',
      device_api_host: 'https://device.jpush.cn/',
      report_api_host: 'https://report.jpush.cn/',
      valid_platform: ['android', 'ios']
    }

    attr_reader :settings

    def init(app_key, master_secret)
      @settings = DEFAULT_OPTIONS.merge!(app_key: app_key, master_secret: master_secret)
    end

  end
end

require 'jpush/device'
require 'jpush/push'
require 'jpush/report'
require 'jpush/schedule'

module JPush
  module API
    def devices
      Device
    end

    def tags
      Tag
    end

    def aliases
      Alias
    end

    def pusher
      Push
    end

    def reporter
      Report
    end

    def schedules
      Schedule
    end
  end

  class Client
    include JPush::API

    def initialize(app_key, master_secret)
      JPush::Config.init(app_key, master_secret)
    end

  end

end

require 'jpush/device'
require 'jpush/pusher'
require 'jpush/report'
require 'jpush/schedules'

module JPush
  class Client

    attr_reader :app_key
    attr_reader :master_secret

    def initialize(app_key, master_secret)
      @app_key = app_key
      @master_secret = master_secret
    end

    def devices
      @devices ||= Device.new(self)
    end

    def tags
      @tag ||= Tag.new(self)
    end

    def aliases
      @alias ||= Alias.new(self)
    end

    def pusher
      @push ||= Pusher.new(self)
    end

    def reporter
      @report ||= Report.new(self)
    end

    def schedules
      @schedule ||= Schedules.new(self)
    end

  end

end

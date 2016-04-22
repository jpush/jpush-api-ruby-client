require 'jpush/api/device'
require 'jpush/api/push'
require 'jpush/api/report'
require 'jpush/api/schedule'

module JPush
  module Api
    extend self

    def devices
      return Api::Device
    end

    def tags
      return Api::Tag
    end

    def aliases
      return Api::Alias
    end

    def pusher
      return Api::Push
    end

    def reporter
      return Api::Report
    end

    def schedules
      return Api::Schedule
    end

  end
end

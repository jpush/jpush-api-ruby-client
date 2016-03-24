require 'jpush/api/device'
require 'jpush/api/push'

module Jpush
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

    def push
      return Api::Push
    end

  end
end

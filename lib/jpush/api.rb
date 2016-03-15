require 'jpush/api/device'

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

  end
end

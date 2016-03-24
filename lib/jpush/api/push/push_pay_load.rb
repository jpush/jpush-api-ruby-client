require 'jpush/api/helper/argument_helper'
require 'jpush/api/push/audience'
require 'jpush/api/push/notification'

module Jpush
  module Api
    module Push
      class PushPayload
        extend Helper::ArgumentHelper

        attr_accessor :platform

        VALID_PLATFORM = ['android', 'ios']

        def initialize(platform: ,audience: )
          platform = build_platform(platform)
          audience = build_audience(audience)
        end

        private

          def build_platform(platform)
            return VALID_PLATFORM if 'all' == platform

            platform.each do |pf|
              raise ArgumentError, "Invalid Platform #{pf.upcase}" unless VALID_PLATFORM.include?(pf)
            end
            platform
          end

          def build_audience(audience)
            return audience if 'all' == audience
          end

      end
    end
  end
end

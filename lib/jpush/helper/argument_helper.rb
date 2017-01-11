require 'jpush/utils/exceptions'

module JPush
  module Helper
    module ArgumentHelper

      def build_extras(extras)
        (extras.nil? || !extras.is_a?(Hash) || extras.empty?) ? nil : extras
      end

      def build_platform(platform)
        [platform].flatten
      end

    end
  end
end

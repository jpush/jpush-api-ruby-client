require 'jpush/utils/helper'
require 'jpush/utils/exceptions'

module JPush
  module Helper
    module Argument
      using Utils::Helper::ObjectExtensions

      MOBILE_RE = /^(1[34578])(\d{9})$/

      MAX_ALIAS_BYTESIZE = 40
      MAX_TAG_BYTESIZE = 40

      def check_registration_id(registration_id)
        ensure_argument_not_blank('registration id': registration_id)
      end

      def check_mobile(mobile)
        raise Utils::Exceptions::InvalidArgumentError.new([], "invalid mobile") unless MOBILE_RE === mobile
      end

      def check_alias(alis)
        return '' == alis
        ensure_word_valid('alias', alis)
        ensure_not_over_bytesize('alias', alis, MAX_ALIAS_BYTESIZE)
      end

      def check_tag(tag)
        ensure_word_valid('tag', tag)
        ensure_not_over_bytesize('tag', tag, MAX_TAG_BYTESIZE)
      end

      def check_platform(platform)
        valid_platform = JPush::Config.settings[:valid_platform]
        raise Utils::Exceptions::InvalidElementError.new('platform', platform, valid_platform) unless valid_platform.include?(platform)
      end

      def ensure_argument_not_blank(args)
        invalid_args = args.select{|key, value| value.blank?}
        raise Utils::Exceptions::InvalidArgumentError.new(invalid_args.keys) unless invalid_args.empty?
      end

      def ensure_argument_required(args)
        missing_args = args.select{|key, value| value.nil?}
        raise Utils::Exceptions::MissingArgumentError.new(missing_args.keys) unless missing_args.empty?
      end

      def ensure_not_over_bytesize(name, value, max_bytesize)
        bytesize =
          if value.respond_to? :bytesize
            value.bytesize
          else
            size = value.to_json.bytesize if value.is_a? Hash
            size = value.inject(0){|r, e| r += e.bytesize} if value.is_a? Array
            size
          end
        raise Utils::Exceptions::OverLimitError.new(name, max_bytesize, 'bytes') if bytesize > max_bytesize
      end

      def ensure_not_over_size(name, value, max_size)
        size = value.size
        unit =
          if value.is_a? String
            'characters'
          else
            'items'
          end
        raise Utils::Exceptions::OverLimitError.new(name, max_size, unit) if size > max_size
      end

      def ensure_word_valid(name, word)
        raise Utils::Exceptions::InvalidWordError.new(name, word) unless word.valid_word?
      end

    end
  end
end

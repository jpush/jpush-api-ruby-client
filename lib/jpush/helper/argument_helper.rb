require 'jpush/helper/argument'
require 'jpush/utils/helper'

module JPush
  module Helper
    module ArgumentHelper
      extend Argument
      using Utils::Helper::ObjectExtensions

      MAX_TAG_ARRAY_SZIE = 100
      MAX_ALIAS_ARRAY_SIZE = 1000
      MAX_REGISTRATION_ID_ARRAY_SIZE = 1000
      MAX_TAG_ARRAY_MAX_BYTESIZE = 1024
      MAX_MSG_IDS_ARRAY_SIZE = 100

      def self.extended(base)
        base.extend Argument
      end

      def build_tags(tags, max_size = MAX_TAG_ARRAY_SZIE)
        tags = build_args_from_array_or_string('tags', tags, max_size)
        ensure_not_over_bytesize('tags', tags, MAX_TAG_ARRAY_MAX_BYTESIZE)
        tags
      end

      def build_registration_ids(ids)
        build_args_from_array_or_string('registration ids', ids, MAX_REGISTRATION_ID_ARRAY_SIZE)
      end

      def build_alias(alis)
        build_args_from_array_or_string('alias', alis, MAX_ALIAS_ARRAY_SIZE)
      end

      def build_msg_ids(msg_ids)
        build_args_from_array_or_string('msg ids', msg_ids, MAX_MSG_IDS_ARRAY_SIZE)
      end

      def build_extras(extras)
        (extras.nil? || !extras.is_a?(Hash) || extras.empty?) ? nil : extras
      end

      def build_platform(platform)
        [platform].flatten.each{ |pf| check_platform(pf) }
      end


      private

        def build_args_from_array_or_string(args_name, args_value, max_size)
          # remove blank elements in args array
          args = [args_value].flatten.compact.reject{ |arg| arg.blank? }.uniq
          ensure_argument_not_blank(args_name.to_sym => args)
          ensure_not_over_size(args_name, args, max_size)
          args.each{|word| ensure_word_valid(args_name, word)}
        end

    end
  end
end

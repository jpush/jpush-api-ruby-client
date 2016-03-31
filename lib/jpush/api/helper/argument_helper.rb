require 'jpush/api/helper/argument_check'
require 'jpush/utils/helper'

module Jpush
  module Api
    module Helper
      module ArgumentHelper
        extend ArgumentCheck
        using Utils::Helper::ObjectExtensions

        MAX_TAG_ARRAY_SZIE = 100
        MAX_ALIAS_ARRAY_SIZE = 1000
        MAX_REGISTRATION_ID_ARRAY_SIZE = 1000
        MAX_TAG_ARRAY_MAX_BYTESIZE = 1024
        MAX_MSG_IDS_ARRAY_SIZE = 100

        def self.extended(base)
          base.extend ArgumentCheck
        end

        def build_tags(tags, max_size = MAX_TAG_ARRAY_SZIE)
          tags = build_args_from_array_or_string('tags', tags, max_size)
          ensure_array_not_over_bytesize('tags', tags, MAX_TAG_ARRAY_MAX_BYTESIZE)
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

        private

          def build_args_from_array_or_string(args_name, args_value, max_size)
            # remove blank elements in args array
            args = [args_value].flatten.compact.reject{ |arg| arg.blank? }.uniq
            ensure_argument_not_blank(args_name, args)
            ensure_array_valid(args_name, args, max_size)
            args
          end

      end
    end
  end
end

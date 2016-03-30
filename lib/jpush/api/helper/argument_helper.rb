require 'jpush/api/helper/argument_check'
require 'jpush/utils/helper'

module Jpush
  module Api
    module Helper
      module ArgumentHelper
        extend ArgumentCheck
        using Utils::Helper::ObjectExtensions

        TAG_ARRAY_LIMIT = 100
        ALIAS_ARRAY_LIMIT = 1000
        REGISTRATION_ID_ARRAY_LIMIT = 1000
        TAG_ARRAY_BYTESIZE_LIMIT = 1024
        MSG_IDS_LIMIT = 100

        def self.extended(base)
          base.extend ArgumentCheck
        end

        def build_tags(tags, max_length = TAG_ARRAY_LIMIT)
          tags = build_args_from_array_or_string('tags', tags, max_length)
          ensure_array_not_over_bytesize('tags', tags, TAG_ARRAY_BYTESIZE_LIMIT)
          tags
        end

        def build_registration_ids(ids)
          build_args_from_array_or_string('registration ids', ids, REGISTRATION_ID_ARRAY_LIMIT)
        end

        def build_alias(alis)
          build_args_from_array_or_string('alias', alis, ALIAS_ARRAY_LIMIT)
        end

        def build_msg_ids(msg_ids)
          build_args_from_array_or_string('msg ids', msg_ids, MSG_IDS_LIMIT)
        end

        private

          def build_args_from_array_or_string(args_name, args_value, limit)
            # remove blank elements in args array
            args = [args_value].flatten.compact.reject{ |arg| arg.blank? }.uniq
            ensure_argument_not_blank(args_name, args)
            ensure_array_valid(args_name, args, limit)
            args
          end

      end
    end
  end
end

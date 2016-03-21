require 'jpush/api/helper/argument_check'
require 'jpush/utils/helper'

module Jpush
  module Api
    module Helper
      module ArgumentHelper
        extend ArgumentCheck
        using Utils::Helper::ObjectExtensions

        def self.extended(base)
          base.extend ArgumentCheck
        end

        def build_tags(tags)
          build_args_from_array_or_string('tags', tags)
        end

        def build_registration_ids(ids)
          build_args_from_array_or_string('registration ids', ids)
        end

        private

          def build_args_from_array_or_string(args_name, args_value)
            # remove blank elements in args array
            args = [args_value].flatten.compact.reject{ |arg| arg.blank? }.uniq
            ensure_argument_not_blank(args_name, args)
            args
          end

      end
    end
  end
end

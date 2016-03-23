require 'jpush/utils/helper'

module Jpush
  module Api
    module Helper
      module ArgumentCheck
        using Utils::Helper::ObjectExtensions

        MOBILE_RE = /^(1[34578])(\d{9})$/

        ALIAS_BYTESIZE = 40
        TAG_BYTESIZE = 40

        def check_registration_id(registration_id)
          ensure_argument_not_blank('registration id', registration_id)
        end

        def check_mobile(mobile)
          raise ArgumentError, "invalid mobile".titleize unless MOBILE_RE === mobile
        end

        def check_alias(alis)
          ensure_word_valid('alias', alis)
          ensure_string_not_over_bytesize('alias', alis, ALIAS_BYTESIZE)
        end

        def check_tag(tag)
          ensure_word_valid('tag', tag)
          ensure_string_not_over_bytesize('tag', tag, TAG_BYTESIZE)
        end

        def ensure_argument_not_blank(arg_name, arg_value)
          raise ArgumentError, "#{arg_name} can not be blank".titleize if arg_value.blank?
        end

        def ensure_argument_not_nil(arg_name, arg_value)
          raise ArgumentError, "#{arg_name} can not be nil".titleize if arg_value.nil?
        end

        def ensure_array_valid(array_name, array, limit)
          errmsg= "invalid #{array_name} ( expect its size less than #{limit} )"
          raise ArgumentError, errmsg.titleize if array.size > limit
          array.each{|word| ensure_word_valid(array_name, word)}
          nil
        end

        def ensure_word_valid(word_name, word)
          errmsg = "invalid #{word_name}: '#{word}'"
          raise ArgumentError, errmsg.titleize unless word.valid_word?
        end

        def ensure_string_not_over_bytesize(str_name, str_value, bytesize)
          errmsg = "invalid #{str_name} ( expect its bytesize less than #{bytesize} byte )"
          raise ArgumentError, errmsg.titleize if str_value.bytesize > bytesize
        end

        def ensure_array_not_over_bytesize(array_name, array, bytesize)
          errmsg = "invalid #{array_name} ( expect its bytesize less than #{bytesize} byte )"
          array_bytesize = array.inject(0){|r, e| r += e.bytesize}
          raise ArgumentError, errmsg.titleize if array_bytesize > bytesize
        end

      end
    end
  end
end

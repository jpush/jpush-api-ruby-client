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

        def ensure_string_not_over_bytesize(str_name, str, limit)
          ensure_not_over_bytesize(str_name, str.bytesize, limit)
        end

        def ensure_array_not_over_bytesize(array_name, array, limit)
          array_bytesize = array.inject(0){|r, e| r += e.bytesize}
          ensure_not_over_bytesize(array_name, array_bytesize, limit)
        end

        def ensure_hash_not_over_bytesize(hash_name, hash, limit)
          hash_bytesize = hash.to_json.bytesize
          ensure_not_over_bytesize(hash_name, hash_bytesize, limit)
        end

        def ensure_not_over_bytesize(arg_name, bytesize, limit)
          errmsg = "invalid #{arg_name} ( expect its bytesize less than #{limit} byte )"
          raise ArgumentError, errmsg.titleize if bytesize > limit
        end

        def ensure_argument_type(obj_name, obj, type)
          errmsg = "#{obj_name} is a #{obj.class} ( expect its type is #{type} )"
          raise ArgumentError, errmsg.titleize unless obj.is_a? type
        end

        def ensure_string_can_convert_to_fixnum(name, str)
          errmsg = "invalid #{name}: #{str} ( expect it can be convert to Fixnum )"
          raise ArgumentError, errmsg.titleize if '0' != str && 0 == str.to_i
        end

      end
    end
  end
end

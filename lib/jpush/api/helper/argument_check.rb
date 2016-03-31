require 'jpush/utils/helper'

module Jpush
  module Api
    module Helper
      module ArgumentCheck
        using Utils::Helper::ObjectExtensions

        MOBILE_RE = /^(1[34578])(\d{9})$/

        MAX_ALIAS_BYTESIZE = 40
        MAX_TAG_BYTESIZE = 40

        def check_registration_id(registration_id)
          ensure_argument_not_blank('registration id', registration_id)
        end

        def check_mobile(mobile)
          raise ArgumentError, "invalid mobile".titleize unless MOBILE_RE === mobile
        end

        def check_alias(alis)
          ensure_word_valid('alias', alis)
          ensure_string_not_over_bytesize('alias', alis, MAX_ALIAS_BYTESIZE)
        end

        def check_tag(tag)
          ensure_word_valid('tag', tag)
          ensure_string_not_over_bytesize('tag', tag, MAX_TAG_BYTESIZE)
        end

        def ensure_argument_not_blank(arg_name, arg_value)
          raise ArgumentError, "#{arg_name} can not be blank".titleize if arg_value.blank?
        end

        def ensure_argument_not_nil(arg_name, arg_value)
          raise ArgumentError, "#{arg_name} can not be nil".titleize if arg_value.nil?
        end

        def ensure_array_valid(array_name, array, max_size)
          errmsg= "#{array_name} must have at most #{max_size} elements )"
          raise ArgumentError, errmsg.titleize if array.size > max_size
          array.each{|word| ensure_word_valid(array_name, word)}
          nil
        end

        def ensure_word_valid(word_name, word)
          errmsg = "invalid #{word_name}: '#{word}'"
          raise ArgumentError, errmsg.titleize unless word.valid_word?
        end

        def ensure_string_not_over_bytesize(str_name, str, max_bytesize)
          ensure_not_over_bytesize(str_name, str.bytesize, max_bytesize)
        end

        def ensure_array_not_over_bytesize(array_name, array, max_bytesize)
          array_bytesize = array.inject(0){|r, e| r += e.bytesize}
          ensure_not_over_bytesize(array_name, array_bytesize, max_bytesize)
        end

        def ensure_hash_not_over_bytesize(hash_name, hash, max_bytesize)
          hash_bytesize = hash.to_json.bytesize
          ensure_not_over_bytesize(hash_name, hash_bytesize, max_bytesize)
        end

        def ensure_not_over_bytesize(arg_name, bytesize, max_bytesize)
          errmsg = "#{arg_name} must have at most #{max_bytesize} byte"
          raise ArgumentError, errmsg.titleize if bytesize > max_bytesize
        end

        def ensure_string_not_over_size(str_name, str, max_size)
          errmsg = "#{str_name} must have at most #{max_size} characters"
          raise ArgumentError, errmsg.titleize if str.size > max_size
        end

        def ensure_integer_not_over_size(name, value, max_size)
          errmsg = "#{name} must be less than or equal #{max_size}"
          raise ArgumentError, errmsg.titleize if value > max_size
        end

      end
    end
  end
end

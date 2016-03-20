require 'jpush/utils/helper'

module Jpush
  module Utils
    module ArgumentCheck
      using Helper::ObjectExtensions

      def check_registration_id(registration_id)
        ensure_argument_not_blank('registration id', registration_id)
      end

      def check_mobile(mobile)
        raise ArgumentError, "mobile is invalid".titleize if mobile.blank? || mobile.length != 11
        nil
      end

      def ensure_argument_not_blank(arg_name, arg_value, errmsg = nil)
        msgerr ||= "#{arg_name} can not be blank"
        raise ArgumentError, msgerr.titleize if arg_value.blank?
        nil
      end

      def ensure_argument_not_nil(arg_name, arg_value, errmsg = nil)
        msgerr ||= "#{arg_name} can not be nil"
        raise ArgumentError, msgerr.titleize if arg_value.nil?
        nil
      end

    end
  end
end

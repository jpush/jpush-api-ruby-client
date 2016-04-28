require 'jpush/helper/argument_helper'

module JPush
  module Push
    class Audience
      extend Helper::ArgumentHelper
      using Utils::Helper::ObjectExtensions

      def set_tag(tags)
        @tag = Audience.build_tags(tags, 20)
        self
      end

      def set_tag_and(tags)
        @tag_and = Audience.build_tags(tags, 20)
        self
      end

      def set_alias(alis)
        @alias = Audience.build_alias(alis)
        self
      end

      def set_registration_id(registration_ids)
        @registration_id = Audience.build_registration_ids(registration_ids)
        self
      end

      def to_hash
        @audience = {
          tag: @tag,
          tag_and: @tag_and,
          alias: @alias,
          registration_id: @registration_id
        }.compact
        raise Utils::Exceptions::JPushError, 'Audience can not be empty.' if @audience.empty?
        @audience
      end

    end
  end
end

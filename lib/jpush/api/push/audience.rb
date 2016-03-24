require 'jpush/api/helper/argument_helper'

module Jpush
  module Api
    module Push
      class Audience
        extend Helper::ArgumentHelper

        attr_reader :audience

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

        def build
          @audience = {
            tag: @tag,
            tag_and: @tag_and,
            alias: @alias,
            registration_id: @registration_id
          }.reject{|key, value| value.nil?}
          Audience.ensure_argument_not_blank('audience', @audience)
          @audience
        end

      end
    end
  end
end

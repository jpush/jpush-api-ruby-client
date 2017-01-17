module JPush
  module Push
    class Audience

      def set_tag(tags)
        @tag = [tags].flatten
        self
      end

      def set_tag_and(tags)
        @tag_and = [tags].flatten
        self
      end

      def set_alias(alis)
        @alias = [alis].flatten
        self
      end

      def set_registration_id(registration_ids)
        @registration_id = [registration_ids].flatten
        self
      end

      def to_hash
        @audience = {
          tag: @tag,
          tag_and: @tag_and,
          alias: @alias,
          registration_id: @registration_id
        }.select { |_, value| !value.nil? }
        @audience
      end

    end
  end
end

require 'jpush/helper/argument_helper'
require 'jpush/push/push_payload'
require 'jpush/schedule/trigger'

module JPush
  module Schedule
    class SchedulePayload
      extend Helper::ArgumentHelper
      using Utils::Helper::ObjectExtensions

      def initialize(name, trigger, push_payload, enabled = nil)
        @name = build_name(name)
        @trigger = build_trigger(trigger)
        @push_payload = build_push_payload(push_payload)
        @enabled = enabled
      end

      def to_update_hash
        @schedule_payload = {
          name: @name,
          enabled: @enabled,
          trigger: @trigger,
          push: @push_payload
        }.compact
        raise Utils::Exceptions::JPushError, 'Schedule update body can not be empty' if @schedule_payload.empty?
        @schedule_payload
      end

      def to_hash
        @schedule_payload = {
          name: @name,
          enabled: true,
          trigger: @trigger,
          push: @push_payload
        }
        hash = @schedule_payload.select { |_, value| value.nil? }
        raise Utils::Exceptions::MissingArgumentError.new(hash.keys) unless hash.empty?
        @schedule_payload
      end

      def build_name(name)
        SchedulePayload.ensure_word_valid('name', name) unless name.nil?
        name
      end

      def build_trigger(trigger)
        return { single: { time: trigger.strftime('%F %T') } } if trigger.is_a? Time
        trigger.is_a?(Trigger) ? trigger.to_hash : nil
      end

      def build_push_payload(push_payload)
        push_payload.is_a?(Push::PushPayload) ? push_payload.to_hash : nil
      end

    end
  end
end

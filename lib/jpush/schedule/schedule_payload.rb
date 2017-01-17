require 'jpush/push/push_payload'
require 'jpush/schedule/trigger'

module JPush
  module Schedule
    class SchedulePayload

      def initialize(name, trigger, push_payload, enabled = nil)
        @name = name
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
        }.select { |_, value| !value.nil? }
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
        @schedule_payload
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

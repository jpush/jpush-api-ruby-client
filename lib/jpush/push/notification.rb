module JPush
  module Push
    class Notification

      def set_alert(alert)
        @alert = alert
        self
      end

      def set_not_alert
        @alert = ''
        self
      end

      def set_android(alert: , title: nil, builder_id: nil, channel_id: nil,
        priority: nil, category: nil, style: nil, alert_type: nil, big_text: nil, inbox: nil, big_pic_path: nil, extras: nil,
        large_icon: nil, small_icon_uri: nil, icon_bg_color: nil, intent: nil,badge_add_num: nil, badge_set_num: nil,
        badge_class: nil, sound: nil, show_begin_time: nil, show_end_time: nil, display_foreground: nil
        )
        @android = {
          alert: alert,
          title: title,
          builder_id: builder_id,
          channel_id: channel_id,
          priority: priority,
          category: category,
          style: style,
          alert_type: alert_type,
          big_text: big_text,
          inbox: inbox,
          big_pic_path: big_pic_path,
          extras: extras,
          large_icon: large_icon,
          intent: intent,
          small_icon_uri: small_icon_uri,
          icon_bg_color: icon_bg_color,
          badge_add_num: badge_add_num,
          badge_set_num: badge_set_num,
          badge_class: badge_class,
          sound: sound,
          show_begin_time: show_begin_time,
          show_end_time: show_end_time,
          display_foreground: display_foreground
        }.select { |_, value| !value.nil? }
        self
      end

      def set_ios(alert: , sound: nil, badge: '+1', available: nil, category:nil, extras: nil,
        contentavailable: nil, mutablecontent: nil, thread: nil, interruption_level: nil)
        contentavailable = available if contentavailable.nil?
        contentavailable = nil unless contentavailable.is_a? TrueClass
        mutablecontent = nil unless mutablecontent.is_a? TrueClass
        @ios = {
          alert: alert,
          sound: sound,
          badge: badge,
          'content-available': contentavailable,
          'mutable-content': mutablecontent,
          category: category,
          extras: extras,
          'thread-id': thread,
          'interruption-level': interruption_level
        }.select { |_, value| !value.nil? }
        self
      end

      def set_hmos(alert: , title: nil, category: , large_icon: nil,
        intent: , badge_add_num: nil, badge_set_num: nil, test_message: nil, receipt_id: nil, extras: nil, style: nil, inbox: nil,
        push_type: nil, extra_data: nil, display_foreground: nil, sound: nil, sound_duration: nil)
        @hmos = {
          alert: alert,
          title: title,
          category: category,
          large_icon: large_icon,
          intent: intent,
          badge_add_num: badge_add_num,
          badge_set_num: badge_set_num,
          test_message: test_message,
          receipt_id: receipt_id,
          extras: extras,
          style: style,
          inbox: inbox,
          push_type: push_type,
          extra_data: extra_data,
          display_foreground: display_foreground,
          sound: sound,
          sound_duration: sound_duration
        }.select { |_, value| !value.nil? }
        self
      end

      def to_hash
        @notification = {
          alert: @alert,
          android: @android,
          ios: @ios,
          hmos: @hmos
        }.select { |_, value| !value.nil? }
        raise Utils::Exceptions::JPushError, 'Notification can not be empty.' if @notification.empty?
        @notification
      end

    end
  end
end

require 'jpush/http/client'
require 'jpush/handler'

module JPush
  class Report < Handler

    TIME_UNIT = ['HOUR', 'DAY', 'MONTH']
    TIME_FORMAT = { hour: '%F %H', day: '%F', month: '%Y-%m' }
    MAX_DURATION = { hour: 24, day: 60, month: 2 }

    # GET /v3/received
    # 送达统计
    def received(msg_ids)
      msg_ids = [msg_ids].flatten
      url = base_url + '/received'
      params = {
        msg_ids: msg_ids.join(',')
      }
      Http::Client.get(@jpush, url, params: params)
    end

    # GET /v3/messages
    # 消息统计
    def messages(msg_ids)
      msg_ids = [msg_ids].flatten
      url = base_url + '/messages'
      params = {
        msg_ids: msg_ids.join(',')
      }
      Http::Client.get(@jpush, url, params: params)
    end

    # GET /v3/users
    # 用户统计
    def users(time_unit, start, duration)
      start = start.strftime(TIME_FORMAT[time_unit.downcase.to_sym])
      duration = build_duration(time_unit.downcase.to_sym, duration)
      params = {
        time_unit: time_unit.upcase,
        start: start,
        duration: duration
      }
      url = base_url + '/users'
      Http::Client.get(@jpush, url, params: params)
    end

    private

      def base_url
        'https://report.jpush.cn/v3/'
      end

      def build_duration(time_unit, duration)
        return 1 if duration < 0
        duration > MAX_DURATION[time_unit] ? MAX_DURATION[time_unit] : duration
      end

  end
end

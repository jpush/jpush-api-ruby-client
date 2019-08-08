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

    # GET /v3/received/detail
    # 送达统计
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_report/#_7
    def received_detail(msg_ids)
      msg_ids = [msg_ids].flatten
      url = base_url + '/received/detail'
      params = {
        msg_ids: msg_ids.join(',')
      }
      Http::Client.get(@jpush, url, params: params)
    end

    # GET /v3/status/message
    # 送达状态查询
    # Status API 用于查询已推送的一条消息在一组设备上的送达状态。
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_report/#_11
    def status_message(msg_id: , registration_ids: , date: nil)
      registration_ids = [registration_ids].flatten
      url = base_url + 'status/message'
      body = {
        msg_id: msg_id,
        registration_ids: registration_ids,
        date: date
      }
      Http::Client.get(@jpush, url, body: body)
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

    # GET /v3/messages/detail
    # 消息统计详情（VIP 专属接口，新）
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_report/#vip_1
    def messages_detail(msg_ids)
      msg_ids = [msg_ids].flatten
      url = base_url + '/messages/detail'
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

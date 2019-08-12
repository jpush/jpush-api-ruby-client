require 'jpush/http/client'
require 'jpush/push/push_payload'
require 'jpush/push/single_push_payload'
require 'jpush/handler'

module JPush
  class Pusher < Handler

    # POST https://api.jpush.cn/v3/push/validate
    # 验证推送调用是否能够成功，与推送 API 的区别在于：不向用户发送任何消息
    def validate(push_payload)
      url = base_url + 'validate'
      send_push(url, push_payload)
    end

    # POST https://api.jpush.cn/v3/push
    # 向某单个设备或者某设备列表推送一条通知、或者消息
    def push(push_payload)
      if push_payload.cid.nil?
        cid_response = get_cid(count=1, type='push')
        cid = cid_response.body['cidlist'].at(0)
        push_payload.set_cid(cid)
      end
      send_push(base_url, push_payload)
    end

    # GET https://api.jpush.cn/v3/push/cid[?count=n[&type=xx]]
    # 获取cid：推送唯一标识符
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_push/#cid
    def get_cid(count=nil, type=nil)
      params = {
        count: count,
        type: type
      }.select { |_, value| !value.nil? }
      url = base_url + 'cid'
      Http::Client.get(@jpush, url, params: params)
    end

    # POST https://api.jpush.cn/v3/push/batch/regid/single
    # 针对RegID方式批量单推（VIP专属接口）
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_push/#vip
    def push_batch_regid(single_push_payloads)
      cid_response = get_cid(count=single_push_payloads.size, type='push')
      cidlist = cid_response.body['cidlist']
      body = {}
      body['pushlist'] = {}
      single_push_payloads.each { |payload|
        cid = cidlist.pop
        body['pushlist'][cid] = payload.to_hash
      }
      url = base_url + 'batch/regid/single'
      Http::Client.post(@jpush, url, body: body)
    end

    # POST https://api.jpush.cn/v3/push/batch/alias/single
    # 针对Alias方式批量单推（VIP专属接口）
    # https://docs.jiguang.cn/jpush/server/push/rest_api_v3_push/#vip
    def push_batch_alias(single_push_payloads)
      cid_response = get_cid(count=single_push_payloads.size, type='push')
      cidlist = cid_response.body['cidlist']
      body = {}
      body['pushlist'] = {}
      single_push_payloads.each { |payload|
        cid = cidlist.pop
        body['pushlist'][cid] = payload
      }
      url = base_url + 'batch/alias/single'
      Http::Client.post(@jpush, url, body: body)
    end

    private

      def send_push(url, push_payload)
        push_payload = push_payload.is_a?(JPush::Push::PushPayload) ? push_payload : nil
        body = push_payload.to_hash
        Http::Client.post(@jpush, url, body: body)
      end

      def base_url
        'https://api.jpush.cn/v3/push/'
      end

  end
end

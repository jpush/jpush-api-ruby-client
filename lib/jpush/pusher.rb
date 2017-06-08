require 'jpush/http/client'
require 'jpush/push/push_payload'
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
      send_push(base_url, push_payload)
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

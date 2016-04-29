require 'jpush/helper/argument_helper'
require 'jpush/schedule/schedule_payload'
require 'jpush/http/client'

module JPush

  module Schedule
    extend self
    extend Helper::ArgumentHelper

    # POST https://api.jpush.cn/v3/schedules
    # 创建一个新的定时任务
    def create(schedule_payload)
      schedule_payload = schedule_payload.is_a?(SchedulePayload) ? schedule_payload : nil
      body = schedule_payload.to_hash
      Http::Client.post(base_url, body: body)
    end

    # GET https://api.jpush.cn/v3/schedules?page=
    # 获取当前有效（endtime未过期）的 schedule 列表
    def tasks(page = nil)
      Http::Client.get(base_url, params: { page: page })
    end

    # 获取指定的定时任务
    # GET https://api.jpush.cn/v3/schedules/{schedule_id}
    def show(schedule_id)
      Http::Client.get(base_url + schedule_id)
    end

    # 修改指定的Schedule
    # PUT https://api.jpush.cn/v3/schedules/{schedule_id}
    def update(schedule_id, name: nil, enabled: nil, trigger: nil, push: nil)
      body = SchedulePayload.new(name, trigger, push, enabled).to_update_hash
      Http::Client.put(base_url + schedule_id, body: body)
    end

    # 删除指定的Schedule任务
    # DELETE https://api.jpush.cn/v3/schedules/{schedule_id}
    def delete(schedule_id)
      Http::Client.delete(base_url + schedule_id)
    end

    private

      def base_url
        Config.settings[:push_api_host] + Config.settings[:api_version] + '/schedules/'
      end

  end
end

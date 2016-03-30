require 'jpush/api/helper/argument_helper'
require 'jpush/http/client'

module Jpush
  module Api
    module Report
      extend self
      extend Helper::ArgumentHelper

      TIME_UNIT = ['DAY', 'MONTH', 'HOUR']

      # GET /v3/received
      # 送达统计
      def received(msg_ids)
        msg_ids = build_msg_ids(msg_ids)
        url = base_url + '/received'
        params = {
          msg_ids: msg_ids.join(',')
        }
        Http::Client.get(url, params: params)
      end

      # GET /v3/messages
      # 消息统计
      def messages(msg_ids)
        msg_ids = build_msg_ids(msg_ids)
        url = base_url + '/messages'
        params = {
          msg_ids: msg_ids.join(',')
        }
        Http::Client.get(url, params: params)
      end

      # GET /v3/users
      # 用户统计
      def users
        # TODO
        # url = base_url + '/users'
      end

      private

        def base_url
          Config.settings[:report_api_host] + Config.settings[:api_version]
        end

    end
  end
end

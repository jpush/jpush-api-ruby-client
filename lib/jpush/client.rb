require 'jpush/util'

module JPush

  class ResponseError < RuntimeError; end
  class PlatformNotSupportError < StandardError; end

  API_URI = "https://api.jpush.cn/v3/push"
  PLATFORM = %w{android ios winphone}

  class Client
    include JPush::Util
    attr_reader :app_key, :master_secret

    def initialize app_key, master_secret, opts = {}
      @app_key = app_key.to_s
      @master_secret = master_secret.to_s
      @options = default_options
      @options.merge!(options: { time_to_live: opts.delete(:time_to_live) }) if opts[:time_to_live]
      @options.merge!(options: { apns_production: opts.delete(:apns_production) }) if opts[:apns_production]
      @options.merge!(platform: opts.delete(:platform)) if opts[:platform]
    end

    # push by alias
    # 参考文档：http://docs.jpush.cn/display/dev/Push-API-v3
    # options:
    # { 
    #   notification: {
    #     alert: "Hi, JPush!"
    #     android: {
    #       builder_id: 3, 
    #       extras: {
    #         news_id: 134, 
    #         my_key: "a value"
    #       }
    #    },
    #    ios: {},
    #    winphone: {}
    #  },
    #  message: {}
    #  audience: ['alias1', 'alias2']
    #}
    #如果需要覆盖全局的推送平台，则加入 platform
    #{
    #  platform: ["android"]
    #}
    def push options = {}
      audience = options.delete(:audience)
      do_post(options.merge(audience: { alias: audience }))
    end

    # broadcast
    # ref #push
    def broadcast_push options = {}
      do_post(options.merge(audience: "all"))
    end

    # push by tag
    # use audience as Array => tag
    # eg: 
    #   audience: ["深圳", "广州"]
    # use audience as Hash{tag, tag_and} => support tag and tag_and
    # eg: 
    #   audience: {
    #     tag: ["深圳", "广州"]
    #     tag_and: ["女", "会员"]
    #   }
    #
    # ref #push
    def tag_push options = {}
      tags = options.delete(:audience)
      audience = if tags.is_a? Array
        { tag: tags }
      elsif tags.is_a? Hash
        tags.select{|k, _| %w{tag tag_and}.include?(k.to_s)}
      end
      do_post(options.merge(audience: audience))
    end

    # push by registration_id
    # use audience as Array
    # ref #push
    def registration_push options = {}
      audience = options.delete(:audience)
      do_post(options.merge(audience: { registration_id: audience }))
    end

    private
    def default_options
      {
        options: {
          sendno: get_random_sendno
        }
      }
    end

    def do_post(options)
      params_hash = @options.merge(options)

      post(API_URI, params_hash)
    end

    def get_random_sendno
      Random.rand(1000000000)
    end

  end
end

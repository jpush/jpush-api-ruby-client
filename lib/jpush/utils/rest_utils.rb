require 'rest-client'
require 'json'

module JPush

  module RestUtils

    # GET JPush API
    def self.get_jpush_api(api_url, headers={})
      _headers = {
                  content_type: 'application/x-www-form-urlencoded',
                  accept: :json,
                 }
      _headers.merge!(headers)
      response = RestClient::Resource.new(api_url,_headers).get();
      response_result = {:response_code => response.code,
                         :x_rate_limit_limit => response.headers[:x_rate_limit_limit] || 0,
                         :x_rate_limit_remaining => response.headers[:x_rate_limit_remaining] || 0,
                         :x_rate_limit_reset => response.headers[:x_rate_limit_reset] || 0,
                         :response_content => JSON.parse(response)
                        }
      response_result
    end

    # POST JPush API
    def self.post_jpush_api(api_url, post_body, headers={})
      _headers = {
          content_type: 'application/x-www-form-urlencoded',
          accept: :json
      }
      _headers.merge!(headers)
      response = RestClient.post(api_url, post_body, _headers)
      response_result = {:response_code => response.code,
                         :x_rate_limit_limit => response.headers[:x_rate_limit_limit] || 0,
                         :x_rate_limit_remaining => response.headers[:x_rate_limit_remaining] || 0,
                         :x_rate_limit_reset => response.headers[:x_rate_limit_reset] || 0,
                         :response_content => JSON.parse(response)
                        }
      response_result
    end
  end
end
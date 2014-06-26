require 'rest_client'
require 'base64'

module JPush
  module Util

    def post uri, params, headers = {}
      RestClient.post uri, params.to_json, default_headers.merge(headers) do |response|
        response
      end
    end

    def get uri, params, headers = {}
      RestClient.get uri, default_headers.merge(headers).merge(params: params) do |response|
        response
      end
    end

    private

    def default_headers
      auth_string = "Basic #{urlsafe_base64_encode(app_key + ':' + master_secret)}"
      { content_type: :json, Authorization: auth_string }
    end

    def urlsafe_base64_encode content
      Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
    end

  end

end

path =  File.expand_path('../', __FILE__)
require File.join(path, 'response_wrapper.rb')
require 'net/http'
require 'json'
require 'logger'
require 'uri'
require 'net/https'

module JPush
  class NativeHttpClient
    def initialize(maxRetryTimes = 5)
      @maxRetryTimes = maxRetryTimes
      @logger = Logger.new(STDOUT)
    end

    def sendPost(url, content, authCode)
      return sendRequest(url, content, 'POST', authCode)
    end

    def sendGet(url, content, authCode)
      return sendRequest(url, content, 'GET', authCode)
    end
    private

    def sendRequest(url, content, method, authCode)
      wrapper = _sendRequest(url, content, method, authCode)
      retryTimes = 0
      while retryTimes < @maxRetryTimes
        begin
          response = _sendRequest(url, content, method, authCode)
          break
        rescue 
          if retryTimes > @maxRetryTimes
            raise RuntimeError.new('connect error')
          else
            @logger.debug('Retry again - ' + (retryTimes + 1).to_s)
            retryTimes = retryTimes + 1
          end
        end
      end
      return wrapper
    end
    private

    def _sendRequest(url, content, method, authCode)
      begin

        header = {}
        header['User-Agent'] = 'JPush-API-Ruby-Client'
        header['Connection'] = 'Keep-Alive'
        header['Charset'] = 'UTF-8'
        header['Content-Type'] = 'application/json'
        header['Authorization'] = authCode
        #url = url+content
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.open_timeout = 30
        http.read_timeout = 30
        use_ssl = true
        if method == 'POST' && use_ssl == true
          req = Net::HTTP::Post.new(uri.path, initheader = header)
          req.body = content
          response = http.request(req)
        elsif method == 'GET' && use_ssl == true
          request = Net::HTTP::Get.new(uri.request_uri, initheader = header)
          response = http.request(request)
        end
        #if method == 'POST'
        # @response = http.post(path,content,header)
        #elsif method == 'GET'
        # @response = http.get2(path,content,header)
        # end
        code = response.code
        code = Integer(code)
        wrapper = JPush::ResponseWrapper.new
        wrapper.code = code
        wrapper.setResponseContent(response.body)
        headers = response.header.to_hash
        quota = response['X-Rate-Limit-Limit']
        remaining = response['X-Rate-Limit-Remaining']
        reset = response['X-Rate-Limit-Reset']

        wrapper.setRateLimit(Integer(quota), Integer(remaining), Integer(reset))
        if code == 200
          @logger.debug('Succeed to get response - 200 OK')
          if content != nil
            @logger.debug('Response Content -' + response.body)
          end
        elsif code > 200 && code < 400
          @logger.warn('Normal response but unexpected - responseCode:' + code.to_s + ',responseContent = ' + response.body)
        else
          @logger.error('Got error response - responseCode:' + code.to_s + ', responseContent:' + response.body)
          case code
          when 400
            @logger.error('Your request params is invalid. Please check them according to error message.')
            wrapper.setErrorObject()
          when 401
            @logger.error('Authentication failed! Please check authentication params according to docs.')
            wrapper.setErrorObject()
          when 403
            @logger.error('Request is forbidden! Maybe your appkey is listed in blacklist?')
            wrapper.setErrorObject()
          when 410
            @logger.error('Request resource is no longer in service. Please according to notice on official website.')
            wrapper.setErrorObject()
          when 429
            @logger.error('Too many requests! Please review your appkey request quota.')
            wrapper.setErrorObject()
          when 501..504
            @logger.error('Seems encountered server error. Maybe JPush is in maintenance? Please retry later.')
          else
          @logger.error('Unexpected response.')    
          end
        end
      rescue SocketError => ex
        raise SocketError.new('socket build error')
      end
      return wrapper
    end
  end
end


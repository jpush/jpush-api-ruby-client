require 'net/http'
require 'json'
require 'logger'
require 'uri'

class NativeHttpClient
  logger = Logger.new(STDOUT);
  def initialize(maxRetryTimes=0)
    @maxRetryTimes=maxRetryTimes;
  end

  def sendPsot(url,content,authCode)
    return sendRequest(url,content,'POST',authCode);
  end

  def sendGet(url,content,authCode)
    return sendRequest(url,content,'GET',authCode);
  end
  private
  def sendRequest(url,content,method,authCode)
   puts url
    response=_sendRequest(url,content,method,authCode)
    retryTimes=0;
    while retryTimes>@maxRetryTimes
      begin
        response=_sendRequest(url,content,method,authCode)
      rescue Exception
        raise RuntimeError.new("connect error") if retryTimes<=@maxRetryTimes

      end
    end
  end
end

def _sendRequest(url,content,method,authCode)
  begin
    header={};
    header['User-Agent']='JPush-API-Ruby-Client';
    header['Connection']='Keep-Alive';
    header['Charset']='UTF-8';
    header['Content-Type']='application/json';
    header['Authorization']=authCode;
    
    url_str = URI.parse(url)
        puts url_str.host
    http = Net::HTTP.new(url_str.host, url_str.port)
    http.use_ssl = true
    http.open_timeout = 5;
    http.read_timeout = 30;
    path =  url_str.path;
    if method=='POST'
      @response= http.post2(path,content,header);
      elsif method=='GET'
      @response= http.get2(path,content,header);
    end
    puts @response
    status=@response.code;
    if code==200
      logger.debug("Succeed to get response - 200 OK");
      logger.debug('Response Content -'+content.to_str);
    elsif code>200&&code<400
      logger.warn('Normal response but unexpected - responseCode:'+code+',responseContent='+conetent.to_str);
    else
      logger.warn("Got error response - responseCode:" + code + ", responseContent:" + conetent.to_str);
      case code
      when 400
        logger.error("Your request params is invalid. Please check them according to error message.");
      when 401
        logger.error("Authentication failed! Please check authentication params according to docs.");
      when 403
        logger.error("Request is forbidden! Maybe your appkey is listed in blacklist?");
      when 410
        logger.error("Request resource is no longer in service. Please according to notice on official website.");
      when 429
        logger.error("Too many requests! Please review your appkey's request quota.");
      when 501..504
        logger.error("Seems encountered server error. Maybe JPush is in maintenance? Please retry later.");
      else
      logger.error("Unexpected response.");
      end
    end
    return response;
  rescue Exception => ex
    p ex
  end

end
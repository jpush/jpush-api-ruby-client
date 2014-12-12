module JPush
  class ResponseWrapper
    attr_accessor :rateLimitQuota, :rateLimitRemaining, :rateLimitReset, :code, :error, :responseContent
    def initialize()

      @logger = Logger.new(STDOUT)
    end
    def setRateLimit(quota, remaining, reset)
      if quota.class != Fixnum
        raise ArgumentError.new('quota is not FIXnum')
      end
      if remaining.class != Fixnum
        raise ArgumentError.new('remaining is not FIXnum')
      end
      if reset.class != Fixnum
        raise ArgumentError.new('reset is not FIXnum')
      end
      @quota = quota
      @remaining = remaining
      @reset = reset
      @logger.debug("JPush API Rate Limiting params - quota:" + quota.to_s + ", remaining:" + remaining.to_s + ", reset:" + reset.to_s)
    end
    
    def setResponseContent(content)
       @responseContent = content
    end
    
    def getResponseContent
      return @responseContent
    end
    
    def setErrorObject
      @error = JSON.parse @responseContent
      @error = @error['error']
    end
  end
end

require 'json'
require 'logger'

module JPush
  class ExistResult
     attr_accessor :result, :isok
     
    def initialize
      @isok=false
    end
    def fromResponse(wrapper)
      if wrapper.code != 200
        logger = Logger.new(STDOUT)
        logger.error('Error response from JPush server. Should review and fix it. ')
        logger.info('HTTP Status:' + wrapper.code.to_s)
        logger.info('Error Message:' + wrapper.error.to_s)
        raise JPush::ApiConnectionException.new(wrapper)
      end
      content = wrapper.getResponseContent
      hash = content.to_json
      @result = hash['result']
      @isok=true
      return self
    end
    
    def toJSON
      array={}
      array['result'] = @result
      return array
    end
    
  end
end

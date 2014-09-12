require 'json'

module JPush
  class AliasUidsResult
     attr_accessor :registration_ids, :isok
     
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
      hash = JSON.parse(content)
      @registration_ids = hash['registration_ids']
      @isok=true
      return self
    end
    
    def toJSON
      array={}
      array['registration_ids'] = @registration_ids
      return array
    end
    
  end
end

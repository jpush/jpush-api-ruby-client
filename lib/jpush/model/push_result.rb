require 'json'

module JPush
  class PushResult
    attr_accessor :sendno, :msg_id, :isok
    def initialize
      @isok=false
    end
    def fromResponse(wrapper)
      if wrapper.code != 200
        logger = Logger.new(STDOUT)
        logger.error('Error response from JPush server. Should review and fix it. ')
        logger.info('HTTP Status:',wrapper.code)
        logger.info('Error Message',wrapper.error)
        raise RuntimeError.new("response error")
      end
      content = wrapper.getResponseContent
      hash = JSON.parse(content)
      @sendno = hash['sendno']
      @msg_id = hash['msg_id']
      @isok=true
      return self
    end
    
    def toJSON
      array={}
      array['sendno'] = @sendno
      array['msg_id'] = @msg_id
      return array.to_json
    end
  end
end
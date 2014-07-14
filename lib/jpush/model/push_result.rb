require 'json'
module JPush
  class PushResult
    attr_accessor :sendno, :msg_id, :isOk
    def initialize
      @isOk = false
    end
    def fromResponse(wrapper)
      if wrapeper.code!=200
        raise RuntimeError.new("response error")
      end
      hash = JSON.parse(wrapper.responseContent)
      @sendno = hash['sendno']
      @msg_id = hash['msg_id']
      @isOk = true
      return self
    end
  end
end
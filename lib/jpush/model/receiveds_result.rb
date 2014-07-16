require 'json'

module JPush
  class ReceivedsResult
    attr_accessor :msg_id, :android_received, :ios_apns_sent, :isok
    def initialize
      @isok = false
    end
    
    def fromResponse(wrapper)
      if wrapeper.code != 200
        logger = Logger.new(STDOUT)
        logger.error('Error response from JPush server. Should review and fix it. ')
        logger.info('HTTP Status:',wrapper.code)
        logger.info('Error Message',wrapper.error)
        raise RuntimeError.new("response error")
      end
      hash = JSON.parse(wrapper.responseContent)
      @msg_id = hash['msg_id']
      @ios_apns_sent = hash['ios_apns_sent']
      @android_received = hash['android_received']
      @isok = true
    end
    
    def toJSON
      json = {}
      json['msg_id'] = @msg_id
      json['ios_apns_sent'] = @ios_apns_sent
      json['android_received'] = @android_received
      return json.to_json
    end
  end
end
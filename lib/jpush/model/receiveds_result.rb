require 'json'
module JPush
  class ReceivedsResult
    attr_accessor :msg_id, :android_received, :ios_apns_sent, :isOk
    def initialize
      @isOk = false
    end
    def fromResponse(wrapper)
      if wrapeper.code != 200
        raise RuntimeError.new("response error")
      end
      hash = JSON.parse(wrapper.responseContent)
      @msg_id = hash['msg_id']
      @ios_apns_sent = hash['ios_apns_sent']
      @android_received = hash['android_received']
      @isOk = true
    end
  end
end
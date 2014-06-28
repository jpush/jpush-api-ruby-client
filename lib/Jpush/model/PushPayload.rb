module JPushApiRubyClient
  class PushPayload
    attr_accessor :platform,:audience,:message,:options,:notification;
    def toJSON
      array={};
      if @platform!=nil then
        array['platform']=@platform.toJSON;
      end
      if @audience!=nil then
        array['audience']=@audience.toJSON;
      end
      if @message!=nil then
        array['message']=@message.toJSON;
      end
      if @options!=nil then
        array['options']=@options.toJSON;
      end
      if @notification!=nil then
        array['notification']=@notification.toJSON;
      end
      return array
    end
  end
end
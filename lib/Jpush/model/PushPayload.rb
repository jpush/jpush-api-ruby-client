  class PushPayload
    attr_accessor :platform,:audience,:message,:options,:notification;
 
    def toJSON
      array={};
      if @platform!=nil then
        array['platform']=@plaform.toJSON;
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
      if @platform!=nil then
        array['platform']=@plaform.toJSON;
      end
    end
  end
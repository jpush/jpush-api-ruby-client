module JPush
  class PushPayload
    attr_accessor :platform,:audience,:message,:options,:notification;
    
    def initialize(opts={})
      @platform=opts[:platform];
      @audience=opts[:audience]
      @message=opts[:message]
      @options=opts[:options]
      @notification=opts[:notification]
    end

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
    def check
      if @audience==nil||@platform==nil
       raise ArgumentError.new(' audience and platform both should be set.')
      end
      if @notification==nil&&@message==nil
        raise ArgumentError.new('notification or message should be set at least one')
      end
      @audience.check
      @platform.check
      if @message!=nil
        @message.check
      end
      if @options!=nil
        @options.check
      end
      if @notification!=nil
        @notification.check
      end
      if @notification.to_s.bytesize+@message.to_s.bytesize>1200
        raise ArgumentError.new('notfication and message‘s size is longer than 1200 ')
      end
      return self;
    end
    #used only the ios nitification is not nil
    def isIOSExceedLength
         if @notification.ios..to_s.bytesize>220
           return false
         else
           return true
         end
    end
    
    def isGlobalExceed
      if @notification.to_s.bytesize+@message.to_s.bytesize>1200
        return false
      else
        return true
      end
    end
  end
end

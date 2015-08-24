module JPush
=begin
The object you should build for sending a push.
@param platform audience must be set
=end
  class PushPayload
    attr_accessor :platform, :audience, :message, :options, :notification
    def initialize(opts = {})
      @platform = opts[:platform]
      @audience = opts[:audience]
      @message = opts[:message]
      @options = opts[:options] || JPush::Options.new
      @notification = opts[:notification]
    end

    def toJSON
      array = {}
      if @platform != nil then
        array['platform'] = @platform.toJSON
      end
      if @audience != nil then
        array['audience'] = @audience.toJSON
      end
      if @message != nil then
        array['message'] = @message.toJSON
      end
      if @options != nil then
        array['options'] = @options.toJSON
      end
      if @notification != nil then
        array['notification'] = @notification.toJSON
      end
      return array
    end

    def self.build(opts = {})
      payload = JPush::PushPayload.new(opts)
      if payload.audience == nil || payload.platform == nil
        raise ArgumentError.new(' audience and platform both should be set.')
      end
      if payload.notification == nil && payload.message == nil
        raise ArgumentError.new('notification or message should be set at least one')
      end

      if payload.notification.to_s.bytesize + payload.message.to_s.bytesize > 1200
        raise ArgumentError.new('notfication and message size is longer than 1200 ')
      end
      if payload.options == nil
        options = JPush::Options.build(
        :time_to_live=> 86400,
        :apns_production=> false)
        payload.options = options
      end
      return payload
    end

    #used only the ios nitification is not nil
    def isIOSExceedLength
      if @notification.toJSON.ios.to_s.bytesize > 220
      return false
      else
      return true
      end
    end

    #Check if the length is too long
    def isGlobalExceed
      if @notification.toJSON.to_s.bytesize + @message.toJSON.to_s.bytesize > 1200
      return false
      else
      return true
      end
    end

  end
end

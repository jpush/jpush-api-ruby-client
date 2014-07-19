module JPush
  class Notification
    attr_accessor :alert, :android, :ios, :winphone
    def initialize(opts = {})
      @alert = opts[:alert]
      @android = opts[:android]
      @ios = opts[:ios]
      @winphone = opts[:winphone]
    end

    def toJSON
      array = {}
      if @alert != nil && alert.lstrip.length > 0
        array['alert'] = @alert
      end
      if @android != nil
        array['android'] = @android.toJSON
      end
      if @ios != nil
        array['ios'] = @ios.toJSON
      end
      if @winphone != nil
        array['winphone'] = @winphone.toJSON
      end

      return array
    end

    def self.build(opts = {})
      notification = JPush::Notification.new(opts)
    end
    
  end
end

module JPush
  class IOSNotification
    attr_accessor :alert, :sound, :badge, :extras, :content_available, :category
    def initialize(opts = {})
      if opts[:badge] != nil
        @badge = opts[:badge]
      else
        @badge = 1
      end
      if opts[:sound] != nil
        @sound = opts[:sound]
      else
        @sound = ''
      end
      @alert = opts[:alert]
      @extras = opts[:extras]
      @content_available = opts[:content_available]
      @category = opts[:category]
    end

    def toJSON
      array = {}
      if @alert != nil then
        array['alert'] = @alert
      end
      if @sound != nil && @sound != false then
        array['sound'] = @sound
      end
      if @badge != nil && @badge != false then
        array['badge'] = @badge
      end
      if @extras != nil then
        array['extras'] = @extras
      end
      if @content_available != nil then
        array['content-available'] = @content_available
      end
      if @category != nil then
        array['category'] = @category
      end
      return array
    end

    def disableSound
      @sound = false
    end

    def disableBadge
      @badge = false
    end

    def self.build(opts = {})
      ios = JPush::IOSNotification.new(opts)
      if ios.alert == nil
        raise ArgumentError.new('the alert should be setted')
      end
      if ios.to_s.bytesize > 220
        raise ArgumentError.new('ios notfication size is longer than 220 ')
      end
      return ios
    end

  end
end

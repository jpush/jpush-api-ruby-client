module JPush
  class WinphoneNotification
    attr_accessor :alert,:title,:_open_page,:extras
    def initialize(opts = {})
      @alert = opts[:alert]
      @title = opts[:title]
      @_open_page = opts[:_open_page]
      @extras = opts[:extras]
    end

    def toJSON
      array = {}
      if @alert != nil then
        array['alert'] = @alert
      end
      if @title != nil then
        array['title'] = @title
      end
      if @_open_page != nil then
        array['_open_page'] = @_open_page
      end
      if @extras != nil then
        array['extras'] = @extras
      end
      return array
    end

    def self.build(opts = {})
      winphone=JPush::WinphoneNotification.new(opts)
      if winphone.alert == nil
        raise ArgumentError.new('winphone the alert should be setted')
      end
      return winphone
    end
    
  end
end

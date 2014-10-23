require 'json'

module JPush
  class UserResult
    attr_accessor  :isok, :time_unit, :start, :duration, :items
    def initialize
      @isok = false
    end

    def fromResponse(wrapper)
      if wrapper.code != 200
        logger = Logger.new(STDOUT)
        logger.error('Error response from JPush server. Should review and fix it. ')
        logger.info('HTTP Status:' + wrapper.code.to_s)
        logger.info('Error Message' + wrapper.error.to_s)
        raise JPush::ApiConnectionException.new(wrapper)
      end
      content = wrapper.getResponseContent
      hash = JSON.parse(content)
      @time_unit = hash['time_unit']
      @start = hash['start']
      @duration = hash['duration']
      @itmes = hash['items']
      @isok = true
      return self
    end

    def toJSON
      array = {}
      array['time_unit'] = @time_unit
      array['start'] = @start
      array['duration'] = @duration
      array['items'] = @items
      return array.to_json
    end

  end


end

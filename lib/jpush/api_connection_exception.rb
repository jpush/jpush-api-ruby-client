path =  File.expand_path('../', __FILE__)
require File.join(path, 'response_wrapper.rb')

module JPush
  class ApiConnectionException < Exception
    attr_accessor :res_wrapper
    def initialize(wrapper)
      @res_wrapper = wrapper
    end
  end
end
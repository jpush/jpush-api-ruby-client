require 'json' 
class APIConnectionException <Excption
 attr_accessor :response
  def initialize(messsge=nil)
   super
  end
  
end

module JPushApiRubyClient
class Notification
  attr_accessor :alert
  def toJSON
    array={}
    if @alert!=nil&&alert.lstrip.length>0
      array['alert']=@alert
    end
    return array
  end
  def check
    if @alert==nil
       raise ArgumentError.new('the alert should be setted')
    end
  end
end
end
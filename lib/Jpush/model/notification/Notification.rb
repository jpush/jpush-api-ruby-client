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
end
end
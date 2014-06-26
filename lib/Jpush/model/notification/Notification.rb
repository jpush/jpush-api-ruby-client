module JPushApiRubyClient
class Notification
  attr_accessor :alert,:ios,:android,:winphone;
  def toJSON
    array={}
    if @alert!=nil
      array['alert']=@alert
    end
    if @ios!=nil
      array['ios']=@ios;
    end
    if @android!=nil
      array['android']=@android
    end
    if @winphone!=nil
      array['winphone']=@winphone
    end
  end
end
end
module JPushApiRubyClient
class WinphoneNotification
  attr_accessor :alert,:title,:_open_page,:extras;
  def toJSON
    array={};
    if !@alert==nil then
      array['alert']=@alert;
    end
    if !@title==nil then
      array['title']=@title;
    end
    if !@_open_page==nil then
      array['_open_page']=@_open_page;
    end
    if !@extras==nil then
      array['extras']=@extras;
    end
  end
end
end
  module JPushApiRubyClient
  class AndroidNotification
    attr_accessor :alert,:title,:builder_id,:extras;
    def toJSON
      array={};
      if !@alert==nil then
        array['alert']=@alert;
      end
      if !@title==nil then
        array['title']=@title;
      end
      if !@builder_id==nil then
        array['builder_id']=@builder_id;
      end
      if !@extras==nil then
        array['extras']=@extras;
      end
      return array;
    end
  end
  end
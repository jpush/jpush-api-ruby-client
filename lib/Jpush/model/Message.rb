 module JPushApiRubyClient
  class Message
    attr_accessor :title,:msg_content,:content_type,:extras;
    def initialize()
      
    end
    def toJSON
      array={};
      if !@title==nil then
        array['title']=@title;
      end
      if !@msg_content==nil then
        array['msg_content']=@msg_content;
      end
      if !@content==nil then
        array['content_type']=@content_type;
      end
      if !@extras==nil then
        array['extras']=@extras;
      end
      return array
    end
    
  end
  end
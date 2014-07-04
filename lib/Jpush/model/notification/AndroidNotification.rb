  module JPushApiRubyClient
  class AndroidNotification
    attr_accessor :alert,:title,:builder_id,:extras;
    
    def initialize(opts={})
      @alert=opts[:alert]
      @title=opts[:title]
      @builder_id=opts[:builder_id]
      @extras=opts[:extras]
    end
    def toJSON
      array={};
      if @alert!=nil then
        array['alert']=@alert;
      end
      if @title!=nil then
        array['title']=@title;
      end
      if @builder_id!=nil then
        array['builder_id']=@builder_id;
      end
      if @extras!=nil then
        array['extras']=@extras;
      end

      return array
    end
      def check
    if @alert==nil
       raise ArgumentError.new('android the alert should be setted')
    end
  end
  end
  end
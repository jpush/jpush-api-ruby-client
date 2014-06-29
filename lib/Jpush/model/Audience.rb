module JPushApiRubyClient
  class Audience
    attr_accessor  :tag,:tag_and, :_alias,:registration_id,:segment,:all;
    def initialize
      @all=false
    end

    def toJSON
      if @all==true then
        return 'all';
      end
      array={};
      if @tag!=nil then
          if @tag.class!=Array
          raise ArgumentError.new('tag is not Array')
        end
        array['tag']=@tag;
      end
      if @_alias!=nil then
        if @_alias.class!=Array
          raise ArgumentError.new('alias is not Array')
        end
        array['alias']=@_alias;
      end
      if @tag_end!=nil  then
        if @tag_end.class!=Array
          raise ArgumentError.new('tag_end is not Array')
        end
        array['tag_end']=@tag_end;
      end
      if @registration_id!=nil then
        if @registration_id.class!=Array
          raise ArgumentError.new('registration_id is not Array')
        end
        array['registration_id']=@registration_id;
      end
      return array;
    end

    def self.all
      au=JPushApiRubyClient::Audience.new
      au.all=true
      return au
    end

    def check
      if @all==true
        if @tag!=nil||@_alias!=nil||@tag_end!=nil||@registration_id!=nil
          raise ArgumentError.new('If audience is all, no any other audience may be set.')
        end
      end
      if @all==false
        if @tag==nil&&@_alias==nil&&@tag_end==nil&&@registration_id==nil
          raise ArgumentError.new('No any audience target is set.')
        end
      end
    end
  end
end
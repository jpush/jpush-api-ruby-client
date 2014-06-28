 module JPushApiRubyClient
  class Audience
     attr_accessor  :tag,:tag_and, :_alias,:registration_id,:segment;


    def toJSON
      if @tag!=nil&&@tag_and!=nil&&@_alias!=nil&&@registration_id!=nil then
        return 'all';
      end
      array={};
        if !@tag==nil then
          array['tag']=@tag;
        end
        if !@_alias==nil then
          array['alias']=@_alias;
        end
        if !@tag_end==nil  then
          array['tag_end']=@tag_end;
        end
        if !@registration_id==nil then
          array['registration_id']=@registration_id;
        end
        return array;
    end
   
  end
  end
  class Audience
     attr_accessor  :tag,:tag_and, :_alias,:registration_id,:segment;
    def initialize
      @tag=false;
      @tag_and=false;
      @alias=false;
      @segment=false;
      @registration_id=false;
    end

    def toJSON
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
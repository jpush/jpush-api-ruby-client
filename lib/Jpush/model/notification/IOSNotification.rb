module JPushApiRubyClient
class IOSNotification
   attr_accessor :alert,:sound,:badge,:extras,:content_available;
   def toJSON
     array={};
     if !@alert==nil then
       array['alert']=@alert;
     end
     if !@sound==nil then
       array['sound']=@sound;
     end
     if !@badge==nil then
       array['badge']=@badge;
     end
     if !@extras==nil then
       array['extras']=@extras;
     end
     if !@contene_available==nil then
       array['contene_available']=@contene_available;
     end
     return array
   end
end
end
module JPushApiRubyClient
class IOSNotification
   attr_accessor :alert,:sound,:badge,:extras,:content_available;
   def initialize
       @badge=1
       @sound=''
       
   end
   def toJSON
     array={};
     if @alert!=nil then
       array['alert']=@alert;
     end
     if @sound!=nil&&@sound!=false then
       array['sound']=@sound;
     end
     if @badge!=nil then
       array['badge']=@badge;
     end
     if @extras!=nil then
       array['extras']=@extras;
     end
     if @contene_available!=nil then
       array['contene_available']=@contene_available;
     end
     return array
   end
   
   def disableSound
     @sound=false
   end
   
     def check
    if @alert==nil
       raise ArgumentError.new('the alert should be setted')
    end
    if self.to_s.bytesize>220
      raise ArgumentError.new('notfication‘s size is longer than 220 ')
    end
  end
end
end
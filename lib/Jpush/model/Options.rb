module JPushApiRubyClient
 class Options
    attr_accessor :sendno,:time_to_live,:override_msg_id,:apns_production;
    def initialize
       @apns_production=false;
    end
    def toJSON
        array={};
           if @sendno!=nil then
                array['sendno']=@sendno;
           end
           if !@time_to_live==nil then
             array['time_to_live']=@time_to_live;
           end
           if !@override_msg_id==nil then
             array['override_msg_id']=@override_msg_id;
           end
           if !@apns_production==nil then
             array['apns_production']=@apns_production;
           end
           return array;
    end
 end
end
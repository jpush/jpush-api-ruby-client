require 'base64'
class ServiceHelper
  @@BASIC_PREFIX='Basic';
  
  def self.getAuthorizationBase64(appKey,masterSecret)
     encodeKey = appKey + ":" + masterSecret;
     return @@BASIC_PREFIX + " " +Base64.encode64(encodeKey);
  end
end

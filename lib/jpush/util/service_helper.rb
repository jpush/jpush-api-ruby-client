require 'base64'
class ServiceHelper
  @@BASIC_PREFIX = 'Basic'
  
  def self.getAuthorizationBase64(appKey, masterSecret)
     encodeKey = appKey + ":" + masterSecret
     value = @@BASIC_PREFIX + " " + Base64.encode64(encodeKey)
     value.gsub!("\n", '')
     return value
  end
end

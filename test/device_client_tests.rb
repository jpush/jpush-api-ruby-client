require 'jpush'
path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')
require 'test/unit'

class DeviceClientTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testGetUserProfile
   result = @client.getUserProfile(REGISTRATION_ID1)
   puts result.alias
  end
end
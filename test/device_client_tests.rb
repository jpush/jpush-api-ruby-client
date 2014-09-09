require 'jpush'
path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')
require 'test/unit'

class DeviceClientTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testgetDeviceTagAlias
    result = @client.getDeviceTagAlias('0900e8d85ef')
    assert(result.isok, message = 'response error')
  end
   def testgetDeviceTagAlias_fail
     assert_raises(JPush::ApiConnectionException, message = "ApiConnectionException") {
       result = @client.getDeviceTagAlias('123123123213')
     }
  end
  def testupdateDeviceTagAlias()
    add = ['tag1', 'tag2'];
    remove = ['tag3', 'tag4'];
    tagAlias = JPush::TagAlias.build(:add=> add, :remove=> remove, :alias=> 'alias1')
    result = @client.updateDeviceTagAlias('0900e8d85ef', tagAlias)
    assert(result.code == 200, message = 'response error')
  end
  
  def testgetAppkeyTagList
    result = @client.getAppkeyTagList
    assert(result.isok, message = 'response error')
  end
  
  def testuserExistsInTag
    result = @client.userExistsInTag('tag1', '0a04ad7d8b4')
    assert(result.isok, message = 'response error')
  end
  
  
  def testtagAddingOrRemovingUsers
    add = ["0900e8d85ef"]
    remove = ["0900e8d85ef"]
    tagManager = JPush::TagManager.build(:add=> add, :remove=> remove)
    result = @client.tagAddingOrRemovingUsers('tag4', tagManager)
    assert(result.code == 200, message = 'response error')
  end
  
  def testtagDelete
    result = @client.tagDelete("tag12312312")
    assert(result.code == 200, message = 'response error')
  end
  
  def testgetAliasUids
    result = @client.getAliasUids('alias1','android,ios')
    assert(result.isok, message = 'response error')
  end
  
  def testaliasDelete
    result = @client.aliasDelete('alias4')
    assert(result.code == 200, message = 'response error')
  end
  
  def testtagAddingOrRemovingUsers_fail
    add = ['0900e8d85ef', '123123123']
    remove = ["0a04ad7d8b4"]
    tagManager = JPush::TagManager.build(:add=> add, :remove=> remove)
    result = @client.tagAddingOrRemovingUsers('tag4', tagManager)
    assert(result.code == 200, message = 'response error')
  end
  

end
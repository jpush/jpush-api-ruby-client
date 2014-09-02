require 'jpush'
path =  File.expand_path('../', __FILE__)
require File.join(path, 'base_remote_tests.rb')
require 'test/unit'

class DeviceClientTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testGetUserProfile
    result = @client.getUserProfile('0900e8d85ef')
    assert(result.isok, message = 'response error')
  end
  
  def testupdateUserDeviceProfile()
    add = ['tag1', 'tag2'];
    remove = ['tag3', 'tag4'];
    tagAlias = JPush::TagAlias.build(:add=> add, :remove=> remove, :alias=> 'alias1')
    result = @client.updateUserDeviceProfile('0900e8d85ef', tagAlias)
    assert(result.code == 200, message = 'response error')
  end
  
  def testgetAppkeyTagList
    result = @client.getAppkeyTagList
    assert(result.isok, message = 'response error')
  end
  
  def testuserExistsInTag
    result = @client.userExistsInTag('tag3', '0900e8d85ef')
    assert(result.isok, message = 'response error')
  end
  
  
  def testtagAddingOrRemovingUsers
    add = ["registration_id_1_to_add", "registration_id_2_to_add"]
    remove = ["registration_id_1_to_remove", "registration_id_2_to_remove"]
    tagManager = JPush::TagManager.build(:add=> add, :remove=> remove)
    result = @client.tagAddingOrRemovingUsers('tag4', tagManager)
    assert(result.code == 200, message = 'response error')
  end
  
  def testtagDelete
    result = @client.tagDelete("tag3")
    assert(result.code == 200, message = 'response error')
  end
  
  def testgetAliasUids
    reslut = @client.getAliasUids('alias')
    assert(result.isok, message = 'response error')
  end
  
  def aliasDelete
    result = @client.aliasDelete('alias4')
    assert(result.code == 200, message = 'response error')
  end
end
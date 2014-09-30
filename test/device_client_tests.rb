require 'jpush'

path =  File.expand_path('../', __FILE__)
require File.join(path, 'remote/base_remote_tests.rb')
require 'test/unit'

class DeviceClientTests < Test::Unit::TestCase
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end

  def testAll
    updateDeviceTagAlias
    getDeviceTagAlias
    getAliasDeviceList_1
    updateDeviceTagAlias_clear
    getetDeviceTagAlias_cleard
    getAppkeyTagList
    tagAddingOrRemovingUsers
    getAppkeyTagList_1
    userExistsInTag
    tagDelete
    getAliasUids_1
    getAliasUids_2
    aliasDelete
    getAppkeyTagList
    updateDeviceTagAlias
  end

  def getDeviceTagAlias
    result = @client.getDeviceTagAlias('0900e8d85ef')
    json = result.toJSON
    tag = ["tag1","tag2"]
    assert(result.isok, message = 'response error')
    assert(json['tags'].eql?(tag), message = 'response error')
    assert_equal('alias1', json['alias'], message = 'resonpse error');
  end

  def updateDeviceTagAlias_clear
    tagAlias = JPush::TagAlias.clear;
    result = @client.updateDeviceTagAlias('0900e8d85ef', tagAlias)
  end

  def getAliasDeviceList_1
    result = @client.getAliasUids('alias1','android,ios')
    assert(result.registration_ids[0] == '0900e8d85ef', message = 'response error')
  end

  def getetDeviceTagAlias_cleard
    result = @client.getDeviceTagAlias('0900e8d85ef')
    json = result.toJSON
    tag = ["tag1","tag2"]
    assert(result.isok, message = 'response error')
    assert(json['tags'].size == 0, message = 'response error')
    assert_equal(nil, json['alias'], message = 'resonpse error');
  end

  def testgetDeviceTagAlias_fail
    assert_raises(JPush::ApiConnectionException, message = "ApiConnectionException") {
      result = @client.getDeviceTagAlias('123123123213')
    }
  end

  def updateDeviceTagAlias()
    add = ['tag1', 'tag2'];
    remove = ['tag3', 'tag4'];
    tagAlias = JPush::TagAlias.build(:add=> add, :remove=> remove, :alias=> 'alias1')
    result = @client.updateDeviceTagAlias('0900e8d85ef', tagAlias)
    assert(result.code == 200, message = 'response error')
  end

  def getAppkeyTagList
    result = @client.getAppkeyTagList
    assert(result.isok, message = 'response error')
  end

  def userExistsInTag
    result = @client.userExistsInTag('tag1', '0a04ad7d8b4')
    assert(result.isok, message = 'response error')
  end

  def tagAddingOrRemovingUsers
    add = ["0900e8d85ef"]
    remove = ["0a04ad7d8b4"]
    tagManager = JPush::TagManager.build(:add=> add, :remove=> remove)
    result = @client.tagAddingOrRemovingUsers('tag4', tagManager)
    assert(result.code == 200, message = 'response error')
  end

  def getAppkeyTagList_1
    result = @client.getAppkeyTagList
    assert(result.tags.index('tag4') != nil, message = 'response error')
  end
  
  def userExistsInTag
    result = @client.userExistsInTag('tag4', '0a04ad7d8b4')
    assert(result.result == false, message = 'response error')
    
    result2 = @client.userExistsInTag('tag4', '0900e8d85ef')
    assert(result2.result, message = 'response error')
  end

  def tagDelete
    result = @client.tagDelete("tag12312312")
    assert(result.code == 200, message = 'response error')
  end

  def getAliasUids_1
    result = @client.getAliasUids('alias1','android,ios')
    assert(result.isok, message = 'response error')
  end

  def getAliasUids_2
    result = @client.getAliasUids('alias1', nil)
    assert(result.isok, message = 'response error')
  end

  def aliasDelete
    result = @client.aliasDelete('alias4')
    assert(result.code == 200, message = 'response error')
  end



end
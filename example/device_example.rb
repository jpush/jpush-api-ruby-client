require 'jpush'

master_secret = '2b38ce69b1de2a7fa95706ea'
app_key = 'dd1066407b044738b6479275'
client = JPush::JPushClient.new(app_key, master_secret)

logger = Logger.new(STDOUT)
# Get user profile
user_profile = client.getDeviceTagAlias('0900e8d85ef')
logger.debug("Got result  " + user_profile.toJSON)

# Update user device profile
add = ['tag1', 'tag2'];
remove = ['tag3', 'tag4'];
tagAlias = JPush::TagAlias.build(:add=> add, :remove=> remove, :alias=> 'alias1')
result = client.updateDeviceTagAlias('0900e8d85ef', tagAlias)
logger.debug("Got result  " + result.code.to_s)

# Appkey Tag List
tag_list = client.getAppkeyTagList
logger.debug("Got result  " + tag_list.toJSON)

# User Exists In Tag
exist_result = client.userExistsInTag('tag3', '0900e8d85ef')
logger.debug("Got result  " + exist_result.result)

# Tag Adding or Removing Users
add = ["0900e8d85ef"]
remove = ["0900e8d85ef"]
tagManager = JPush::TagManager.build(:add=> add, :remove=> remove)
result = client.tagAddingOrRemovingUsers('tag4', tagManager)
logger.debug("Got result  " + result.code.to_s)

# Tag Delete
result = client.tagDelete("tag3")
logger.debug("Got result  " + result.code.to_s)

# get alias uids
alias_uids = client.getAliasUids('alias')
logger.debug("Got result  " + alias_uids.toJSON)

# Alias Delete
result = client.aliasDelete('alias4')
logger.debug("Got result  " + result.code.to_s)

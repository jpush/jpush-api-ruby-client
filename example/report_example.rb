require 'jpush'

master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPush::JPushClient.new(app_key, master_secret);
logger = Logger.new(STDOUT);
#getReceiveds
result=client.getReportReceiveds('1942377665')
 logger.debug("Got result - " + result)
#getMessages
result=client.getReportMessages('1942377665')
 logger.debug("Got result - " + result)
#getUsers
 result=client.getReportUsers('DAY',"2014-06-10",'3')
logger.debug("Got result - " + result)

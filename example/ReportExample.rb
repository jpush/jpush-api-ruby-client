require 'jpush_api_ruby_client'



master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPushApiRubyClient::JPushClient.new(app_key, master_secret);

#getMessageorReceiveds
result=client.getReportMessages('1942377665')
puts result

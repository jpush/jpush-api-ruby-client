# JPush Api Ruby Client


##概述
这是 JPush REST API 的 Java 版本封装开发包，是由极光推送官方提供的，一般支持最新的 API 功能。

对应的 REST API 文档：<http://docs.jpush.cn/display/dev/REST+API>
[JPush Api Ruby Client Doc](http://www.rdoc.info/github/jpush/jpush-api-ruby-client/master/frames)

## Installation

Add this line to your application's Gemfile:

    gem 'JPush'

And then execute:

    $ bundle

Or install it yourself as:


local install

    $ gem build jpush_api_ruby_client.gemspec
    $ gem install jpush_api_ruby_client -l


##使用样例
###推送样例
> 以下片断来自项目代码里的文件：example/push_example.rb
```ruby
require 'JPush'
master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPush::JPushClient.new(app_key, master_secret);
logger = Logger.new(STDOUT);
#send broadcast
payload1 =JPush::PushPayload.new(
platform: JPush::Platform.all,
audience: JPush::Audience.all,
notification: JPush::Notification.new(alert: 'alert meassage')
).check
result = client.sendPush(payload1);
 logger.debug("Got result  " + result)
``` 

###统计获取样例
> 以下片断来自项目代码里的文件：example/report_example.rb

```ruby
require 'JPush'
master_secret='2b38ce69b1de2a7fa95706ea';
app_key='dd1066407b044738b6479275';
client=JPush::JPushClient.new(app_key, master_secret);
logger = Logger.new(STDOUT);
#getReceiveds
result=client.getReportReceiveds('1942377665')
 logger.debug("Got result - " + result)
```

##单元测试
运行test文件夹的.rb文件
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

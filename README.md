[![Build Status](https://travis-ci.org/jpush/jpush-api-ruby-client.svg?branch=master)](https://travis-ci.org/jpush/jpush-api-ruby-client)
[![Gem Version](https://badge.fury.io/rb/jpush.svg)](https://rubygems.org/gems/jpush)
[![Gem Downloads](http://ruby-gem-downloads-badge.herokuapp.com/jpush)](https://rubygems.org/gems/jpush)


# JPush API Ruby Client

##概述

这是 JPush REST API 的 Ruby 版本封装开发包，是由极光推送官方提供的，一般支持最新的 API 功能。

gem : (https://rubygems.org/gems/jpush)

对应的 REST API 文档：<http://docs.jpush.cn/display/dev/REST+API>  

[JPush API Ruby Client Doc](http://www.rdoc.info/github/jpush/jpush-api-ruby-client/master/frames)

## Installation

Add this line to your application's Gemfile:

    gem 'JPush'

And then execute:

    $ bundle

Or install it yourself as:


local install

    $ gem build jpush.gemspec
    $ gem install jpush -l


##使用样例

###推送样例

> 以下片断来自项目代码里的文件：example/push_example.rb

```ruby
require 'JPush'

master_secret = '2b38ce69b1de2a7fa95706ea';
app_key = 'dd1066407b044738b6479275';
client = JPush::JPushClient.new(app_key, master_secret);

logger = Logger.new(STDOUT);

payload =JPush::PushPayload.new(platform: JPush::Platform.all,
	audience: JPush::Audience.all,
	notification: JPush::Notification.new(alert: 'alert meassage')
).check

result = client.sendPush(payload);
logger.debug("Got result  " + result)

``` 

###统计获取样例

> 以下片断来自项目代码里的文件：example/report_example.rb

```ruby
require 'JPush'

master_secret = '2b38ce69b1de2a7fa95706ea';
app_key = 'dd1066407b044738b6479275';
client = JPush::JPushClient.new(app_key, master_secret);
logger = Logger.new(STDOUT);

#getReceiveds
result = client.getReportReceiveds('1942377665')
logger.debug("Got result - " + result)
```

##单元测试

$ rake


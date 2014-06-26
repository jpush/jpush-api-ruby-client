# JpushApiRubyClient

JPush API Ruby 客户端

GitHub from https://github.com/jpush/jpush-api-ruby-client

forked from https://github.com/lanrion/jpush_ruby_sdk
感谢作者做的先期工作

## Installation

Add this line to your application's Gemfile:

    gem 'jpush', github: 'smartlion/jpush-api-ruby-client', branch: 'v3'

And then execute:

    $ bundle

Or install it yourself as:

local install

    $ gem build jpush.gemspec
    $ gem install jpush -l


##Example

 Detailes refer to [Example](https://github.com/smartlion/jpush-api-ruby-client/blob/v3/test/test_jpush_client.rb)

## Usage

 除 audience 以外，其他参数基本与 [Push API V3](http://docs.jpush.cn/display/dev/Push-API-v3) 类似

### Push via alias

 audience 要求传递一个 Array, 表示要推送的 alias 列表

```ruby
client = JPush::Client.new(app_key, master_key, platform: 'all')
client.push({notification: { alert: 'Hi, JPush!' }, audience: ['alias1', 'alias2']})
```

### Broadcast

```ruby
client = JPush::Client.new(app_key, master_key, platform: 'all')
client.broacast_push({notification: { alert: 'Hi, JPush!' }})
```

### Push via Tag

1. 如果 andience 传递一个 Array, 则表示使用 tag 推送: [Tag Push Example](http://docs.jpush.cn/display/dev/Push-API-v3#highlighter_909330)

```ruby
client = JPush::Client.new(app_key, master_key, platform: 'all')
client.tag_push({notification: { alert: 'Hi, JPush!' }, audience: ['tag1', 'tag2']})
```

2. 如果 andience 传递一个 Hash, 则代表混合使用 tag 和 tag_and: [Tag and Tag_and Example](http://docs.jpush.cn/display/dev/Push-API-v3#highlighter_500738)

```ruby
client = JPush::Client.new(app_key, master_key, platform: 'all')
client.tag_push({notification: { alert: 'Hi, JPush!' }, audience: { tag: ['tag1', 'tag2'], tag_and: ['tag_and1', 'tag_and2'] }})
```

### Push via registration_id

```ruby
client = JPush::Client.new(app_key, master_key, platform: 'all')
client.registration_push({notification: { alert: 'Hi, JPush!' }, audience: ['4312kjklfds2', '8914afd2']})
```

## Test

```ruby
bundle exec rake test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

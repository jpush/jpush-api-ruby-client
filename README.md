# JPush API Ruby Client

这是 JPush REST API 的 Ruby 版本封装开发包，是由极光推送官方提供的，一般支持最新的 API 功能。
对应的 REST API 文档： http://docs.jpush.io/server/server_overview/
支持 Ruby 版本 >= 2.2.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jpush', git: 'https://github.com/jpush/jpush-api-ruby-client.git'
```

## Usage

#### Getting Started

[Where to get app_key or master_secret?](https://www.jpush.cn/common/apps/new)

```ruby
app_key = 'xxx'
master_secret = 'xxx'
jpush = Jpush::Config.init(app_key, master_secret)
```

#### Device API

```ruby
devices = jpush.devices
tags = jpush.tags
aliases = jpush.aliases
```

###### 查询设备 (设备的别名与标签)

```ruby
# 获取当前设备的所有属性，包含标签 tags, 别名 alias， 手机号码 mobile
devices.show(registration_id)
```

###### 更新设备 (设备的别名与标签)

```ruby
# 为设备添加/移除标签
# 参数 tags 为一个表示有效的 tag 字符串或者一个最多包含100个有效的 tag 字符串的数组
devices.add_tags(registration_id, tags)
devices.remove_tags(registration_id, tags)

# 清除设备所有标签
devices.clear_tags(registration_id)

# 更新设备的别名
devices.update_alias(registration_id, alis)

# 删除设备的别名
devices.delete_alias(registration_id)

# 更新设备的手机号码
devices.update_mobile(registration_id)
```

###### 获取用户在线状态（VIP专属接口）

```ruby
# 参数 registration_ids 为一个表示有效的 registration_id 字符串
# 或者一个最多包含1000个有效的 registration_id 字符串的数组
device.status(registration_ids)
```

###### 查询标签列表

```ruby
# 获取应用的所有标签列表
tags.list
```

###### 判断设备与标签的绑定

```ruby
# 查询某个设备是否在标签下
tags.has_device?(tag_value, registration_id)
```

###### 更新标签 (与设备的绑定的关系)

```ruby
# 为一个标签添加/移除设备
# 参数 registration_ids 为一个表示有效的 registration_id 字符串
# 或者一个最多包含1000个有效的 registration_id 字符串的数组
tags.add_devices(tag_value, registration_ids)
tags.remove_devices(tag_value, registration_ids)
```

###### 删除标签 (与设备的绑定关系)

```ruby
# 删除一个标签，以及标签与设备之间的关联关系, platform 可选参数，不填则默认为所有平台
tags.delete(tag_value, platform)
```

###### 查询别名 (与设备的绑定关系)

```ruby
# 获取指定别名下的设备，最多输出10个, platform 可选参数，不填则默认为所有平台
aliases.show(alias_value, platform)
```

###### 删除别名 (与设备的绑定关系)

```ruby
# 删除一个别名，以及该别名与设备的绑定关系, platform 可选参数，不填则默认为所有平台
aliases.delete(alias_value, platform)
```

#### Push API

```ruby
pusher = jpush.pusher

# simplest push Hello to all
push_payload = Jpush::Api::Push::PushPayload.new(
  platform: 'all',
  audience: 'all',
  notification: 'hello jpush',
  message: 'hello world'
).build
pusher.push(push_payload)
```

###### 构建复杂的 Audience 对象

```ruby
# set_tag 和 set_tag_and 方法接受一个有效的 tag 字符串或者一个最多包含20个有效的 tag 字符串的数组
# 同样的 set_alias 和 set_registration_id 方法接受最多包含1000个
audience = Jpush::Api::Push::Audience.new
audience.set_tag('tag')
audience.set_tag_and('tag_and')
audience.set_alias('alias')
audience.set_registration_id('rid')
audience.build

# OR
audience = Jpush::Api::Push::Audience.new.
  set_tag('tag').
  set_tag_and('tag_and').
  set_alias('alias').
  set_registration_id('rid').
  build
```

###### 构建复杂的 Notification 对象

```ruby
hash = { key0: 'value0', key1: 'value1' }

notification = Jpush::Api::Push::Notification.new

notification.set_alert('alert')
notification.set_not_alert    # 不展示到通知栏

notification.set_android(alert: 'hello android')
notification.set_android(
  alert: 'hello',
  title: 'android',
  builder_id: 1,
  extras: hash
)

notification.set_ios(alert: 'hello ios')
notification.set_ios(
  alert: 'hello',
  sound: 'sound',
  badge: '+1',
  available: true,
  category: 'category',
  extras: hash
)

notification.build

# OR
notification = Jpush::Api::Push::Notification.new.
  set_alert('alert').
  set_android(alert: 'hello android').
  set_ios(alert: 'hello ios').
  build
```

###### 构建复杂 PushPayload 对象

```ruby
hash = { key0: 'value0', key1: 'value1' }

# audience 和 notification 对象可按照上面的例子实例化
audience = Jpush::Api::Push::Andience.new
notification = Jpush::Api::Push::Notification.new

# 初始化 PushPayload 对象
push_payload = Jpush::Api::Push::PushPayload.new(
  platform: 'android',
  audience: audience,
  notification: notification
)

# 添加应用内消息
push_payload.set_message(
  'msg_content',
  title: 'hello message',
  content_type: 'text',
  extras: hash
)

# 添加短信业务
push_payload.set_sms_message('sms_content', 10)

push_payload.build

# OR
push_payload = Jpush::Api::Push::PushPayload.new(
  platform: 'android',
  audience: audience,
  notification: notincation).
  set_message(
    'msg_content',
    title: 'hello message',
    content_type: 'text',
    extras: hash
  ).set_sms_message('sms_content', 10).
  build
```

###### 推送消息

```ruby
pusher.push(push_payload)
```

#### Report API

```ruby
reporter = jpush.reporter
```

###### 送达统计

```ruby
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.received(msg_ids)
```

###### 消息统计（VIP专属接口）

```ruby
# 与”送达统计” API 不同的是，该 API 提供更多的的统计数据
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.messages(msg_ids)
```

###### 用户统计（VIP专属接口）

```ruby
# 提供近2个月内某时间段的用户相关统计数据：新增用户、在线用户、活跃用户
# 参数 time_unit 表示时间单位，支持：HOUR（小时）、DAY（天）、MONTH（月） （不区分大小写）
# 参数 start 接受一个 Time 类的实例，表示统计的起始时间，会根据参数 time_unit 自动的转换成需要的格式
# 参数 duration 表示统计持续的时长，根据参数 time_unit 的不同有不同的取值范围，
# 若 time_unit 为 'MONTH' 其范围为1至2，若 time_unit 为 'DAY' 其范围为1至60，
# 若 time_unit 为 'HOUR'，其范围为1至24，并且只支持输出当天的统计结果，
# 若 duration 超过限定的最大取值，则取最大值。
reporter.users(time_unit, start, duration)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

```bash
# 复制测试的配置文件
$ cp test/config.yml.example test/config.yml

# 编辑 test/config.yml 文件，填入必须的变量值
# OR 设置相应的环境变量

# 运行全部测试用例
$ bundle exec test

# 运行某一具体测试用例
$ bundle exec rake test TEST=test/jpush/xx_test.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jpush/jpush-api-ruby-client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


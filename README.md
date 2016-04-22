[![](http://community.jpush.cn/uploads/default/original/1X/a1dbd54304178079e65cdc36810fdf528fdebe24.png)](http://community.jpush.cn/)

# JPush API Ruby Client

这是 JPush REST API 的 Ruby 版本封装开发包，是由极光推送官方提供的，一般支持最新的 API 功能。
对应的 REST API 文档: http://docs.jpush.io/server/server_overview/,
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
jpush = JPush::Config.init(app_key, master_secret)
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
# 参数 registration_ids 为一个表示有效的 registration_id 字符串或者一个最多包含1000个有效的 registration_id 字符串的数组
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
# 参数 registration_ids 为一个表示有效的 registration_id 字符串或者一个最多包含1000个有效的 registration_id 字符串的数组
tags.add_devices(tag_value, registration_ids)
tags.remove_devices(tag_value, registration_ids)
```

###### 删除标签 (与设备的绑定关系)

```ruby
# 删除一个标签，以及标签与设备之间的关联关系, platform 默认为所有平台
tags.delete(tag_value, platform = nil)
```

###### 查询别名 (与设备的绑定关系)

```ruby
# 获取指定别名下的设备，最多输出10个, platform 默认为所有平台
aliases.show(alias_value, platform = nil)
```

###### 删除别名 (与设备的绑定关系)

```ruby
# 删除一个别名，以及该别名与设备的绑定关系, platform 默认为所有平台
aliases.delete(alias_value, platform = nil)
```

#### Push API

```ruby
pusher = jpush.pusher

# simplest push Hello to all
push_payload = JPush::Api::Push::PushPayload.new(
  platform: 'all',
  audience: 'all',
  notification: 'hello jpush',
  message: 'hello world'
).build
pusher.push(push_payload)
```

###### 构建复杂的 Audience 对象

推送设备对象，表示一条推送可以被推送到哪些设备列表。
如果要发广播（全部设备），不需要构建 Audience 对象，在新建 PushPayload 对象的时候，给 'audience' 直接传递 'all'即可。
广播外的设备选择方式，有4种类型： tag, tag_and, alias, registration_id
4 种类型至少需要有其一, 这几种类型并存时多项的隐含关系是 AND，即取交集。

```ruby
# 参数 tag 和 tag_and 为一个有效的 tag 字符串或者一个最多包含20个有效的 tag 字符串的数组
# 参数 alias 为一个表示有效的 alias 字符串或者一个最多包含1000个有效的 alias 字符串的数组
# 参数registration_ids 为一个表示有效的 registration_id 字符串或者一个最多包含1000个有效的 registration_id 字符串的数组
audience = JPush::Api::Push::Audience.new
audience.set_tag(tag)
audience.set_tag_and(tag_and)
audience.set_alias(alis)
audience.set_registration_id(registration_ids)
audience.build

# OR
audience = JPush::Api::Push::Audience.new.
  set_tag(tag).
  set_tag_and(tag_and).
  set_alias(alis).
  set_registration_id(registration_ids).
  build
```

###### 构建复杂的 Notification 对象

若通知的内容在各个平台上，都只有 'alert' 这一个最基本的属性,
则不需要构建 Notifacation 对象，在新建 PushPayload 对象的时候，给 'notication' 直接传递 alert 字符串即可。

```ruby
notification = JPush::Api::Push::Notification.new

notification.set_alert(alert)
notification.set_not_alert    # 不展示到通知栏

# 参数 extra 为一个 Hash 对象，表示自定义扩展字段以供业务使用
notification.set_android(alert: , title: nil, builder_id: nil, extras: nil)
# 参数 available 表示推送唤醒，仅能接受 true 或者 nil
notification.set_ios(alert: , sound: nil, badge: nil, available: nil, category: nil, extras: nil)

notification.build

# OR
notification = JPush::Api::Push::Notification.new.
  set_alert(alert).
  set_android(alert: , title: nil, builder_id: nil, extras: nil).
  set_ios(alert: , sound: nil, badge: nil, available: nil, category: nil, extras: nil).
  build
```

###### 构建复杂 PushPayload 对象

一个推送对象，表示一条推送相关的所有信息，通知内容体。是被推送到客户端的内容。
notification 和 message 二者必须有其一，可以二者并存。

```ruby
# audience 和 notification 对象可按照上面的例子实例化
audience = JPush::Api::Push::Andience.new
notification = JPush::Api::Push::Notification.new

# 初始化 PushPayload 对象
# 参数 platform 表示推送的平台，其可接受的参数为 'all'（表示推送到所有平台）, 'android' 或 'ios'
# 参数 audience 表示推送的设备，其可接受的参数为 'all' （表示发广播（推送到全部设备）） 或者一个 Audience 对象
# 参数 notification 接受一个字符串（表示为仅设置最基本的属性 'alert'） 或者一个 Notifcation 对象
# 参数 message 仅接受一个字符串来快速设置消息内容本身
push_payload = JPush::Api::Push::PushPayload.new(
  platform: , audience: , notification: , message:
)

# 添加应用内消息
# 参数 extra 为一个 Hash 对象，表示自定义扩展字段以供业务使用
push_payload.set_message(msg_content, title: nil，content_type: nil, extras: nil)

# 添加短信业务
# 参数 content 表示短信内容，不能超过480个字符
# 参数 delay_time 表示短信发送的延迟时间，单位为秒，不能超过24小时。
# 该参数仅对android平台有效。默认为 0，表示立即发送短信
push_payload.set_sms_message(content, delay_time = 0)

push_payload.build

# OR
push_payload = JPush::Api::Push::PushPayload.new(
  platform: , audience: , notification: ).
  set_message(msg_content, title: nil，content_type: nil, extras: nil).
  set_sms_message(content, delay_time).
  build
```

###### 推送消息

```ruby
# 仅接受一个 PushPayload对象参数
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
# 与送达统计 API 不同的是，该 API 提供更多的的统计数据
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

#### Schedule API

```ruby
schedules = jpush.schedules
```

###### 构建 Trigger 对象

表示schedule任务的触发条件，当前只支持定时任务（single）或定期任务（periodical）

```ruby
# 定时任务（single）
# 参数 time 接受一个 Time 对象
single = JPush::Api::Schedule::Trigger.new.set_single(time)

# 定期任务（periodical)
# 参数 start_time 和 end_time 表示定期任务有效起始时间与过期时间，都接受一个 Time 对象
# 参数 time 表示触发定期任务的定期执行时间， 其接受一个表示24小时制时间（时分秒）的字符串，例如：'12：07'
# 参数 time_unit 表示定期任务的执行的最小时间单位 可选 'day'，'week' 或 'month'
# 参数 frequency 与time_unit的乘积共同表示的定期任务的执行周期
# 参数 point 接受一个数组，此项与time_unit相对应：
#   当time_unit为day时point此项无效
#   当time_unit为week时，point为数组 ['MON','TUE','WED','THU','FRI','SAT','SUN'] 的子数组，表示星期几进行触发
#   当time_unit为month时，point为当前进行月对应的日期， 为数组['01', '02' , ..,  '31'] 的子数组
periodical = JPush::Api::Schedule::Trigger.new.set_periodical(start_time, end_time, time, time_unit, frequency, point)
```

###### 构建 SchedulePayload 对象

```ruby
# 参数 triggle 接受一个 Trigger 对象，或者一个 Time 对象快速设置 single 定时任务
# 参数 push 仅接受一个有效的 PushPayload 对象
JPush::Api::Schedule::SchedulePayload.new(name, trigger, push)
```

###### 创建定时任务

```ruby
# 参数 schedule_payload 仅接受一个有效的 SchedulePayload 对象
schedules.create(schedule_payload)
```

###### 获取有效的定时任务列表

```ruby
# 返回当前请求页的详细的 schedule-task 列表，如未指定page则page为1
schedules.tasks(page)
```

###### 获取定时任务详情

```ruby
schedules.show(schedule_id)
```

###### 更新定时任务

```ruby
# 更新操作必须为 'name','enabled','trigger' 或 'push' 四项中的一项或多项
# 参数 triggle 接受一个 Trigger 对象，或者一个 Time 对象快速设置 single 定时任务
# 参数 push 仅接受一个有效的 PushPayload 对象
schedules.update(schedule_id, name: nil, enabled: nil, trigger: nil, push: nil)
# 例如只更新 name
schedules.update(schedule_id, name: 'jpush')
```

###### 删除定时任务

```ruby
schedules.delete(schedule_id)
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

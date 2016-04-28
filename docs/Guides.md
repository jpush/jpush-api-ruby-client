# 目录

- [Getting Started](#getting-started)
- [Push API](#push-api)
 - [构建 Audience 对象](#构建-audience-对象)
 - [构建 Notification 对象](#构建-notification-对象)
 - [构建 PushPayload 对象](#构建-pushpayload-对象)
 - [推送消息](#推送消息)
- [Report API](#report-api)
 - [送达统计](#送达统计)
 - [消息统计（VIP专属接口）](#消息统计vip专属接口)
 - [用户统计（VIP专属接口）](#用户统计vip专属接口)
- [Schedule API](#schedule-api)
 - [构建 Trigger 对象](#构建-trigger-对象)
 - [构建 SchedulePayload 对象](#构建-schedulepayload-对象)
 - [创建定时任务](#创建定时任务)
 - [获取有效的定时任务列表](#获取有效的定时任务列表)
 - [获取定时任务详情](#获取定时任务详情)
 - [更新定时任务](#更新定时任务)
 - [删除定时任务](#删除定时任务)
- [Device API](#device-api)
 - [查询设备](#查询设备-设备的别名与标签)
 - [更新设备](#更新设备-设备的别名与标签)
 - [获取用户在线状态（VIP专属接口）](#获取用户在线状态vip专属接口)
 - [查询标签列表](#查询标签列表)
 - [判断设备与标签的绑定](#判断设备与标签的绑定)
 - [更新标签](#更新标签-与设备的绑定的关系)
 - [删除标签](#删除标签-与设备的绑定关系)
 - [查询别名](#查询别名-与设备的绑定关系)
 - [删除别名](#删除别名-与设备的绑定关系)

## Getting Started

[Where to get app_key or master_secret?](https://www.jpush.cn/common/apps/new)

```ruby
app_key = 'xxx'
master_secret = 'xxx'
jpush = JPush::Client.new(app_key, master_secret)
```

## Push API

```ruby
pusher = jpush.pusher

# simplest push Hello to all
push_payload = JPush::Push::PushPayload.new(
  platform: 'all',
  audience: 'all',
  notification: 'hello jpush',
  message: 'hello world'
)
pusher.push(push_payload)
```

#### 构建 Audience 对象

推送设备对象，表示一条推送可以被推送到哪些设备列表。
如果要发广播（全部设备），不需要构建 Audience 对象，在新建 PushPayload 对象的时候，给 'audience' 参数直接传递字符串 'all' 即可。
广播外的设备选择方式，有4种类型： tag, tag_and, alias, registration_id, **4种类型至少需要有其一, 这几种类型并存时多项的隐含关系是 AND，即取交集**

```ruby
audience = JPush::Push::Audience.new
audience.set_tag(tag)
audience.set_tag_and(tag_and)
audience.set_alias(alis)
audience.set_registration_id(registration_ids)

# 链式调用
audience = JPush::Push::Audience.new.
  set_tag(tag).
  set_tag_and(tag_and).
  set_alias(alis).
  set_registration_id(registration_ids)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| tag | 否 | 有效的标签字符串或者一个最多包含20个有效的标签字符串的数组 |
| tag_and | 否 | 有效的标签字符串或者一个最多包含20个有效的标签字符串的数组 |
| alis | 否 | 有效的别名字符串或者一个最多包含1000个有效的别名字符串的数组 |
| registration_ids | 否 | 有效的 registration id 字符串或者一个最多包含1000个有效的 registration id 字符串的数组 |

#### 构建 Notification 对象

若通知的内容在各个平台上，都只有 'alert' 这一个最基本的属性,
则不需要构建 Notifacation 对象，在新建 PushPayload 对象的时候，给 'notication' 参数直接传递表示 alert 的字符串即可，
也可以在 Notifacation 对象中设置 alert 属性。
其下属属性包含3种，2个平台属性，以及一个 'alert' 属性。

```ruby
notification = JPush::Push::Notification.new
```

###### alert

```ruby
notification.set_alert(alert)
```

###### android

```ruby
notification.set_android(
  alert: alert,
  title: title,
  builder_id: builder_id,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| alert | 是 | 表示通知内容，会覆盖上级统一指定的 alert 信息；内容可以为空字符串，表示不展示到通知栏 |
| title | 否 | 表示通知标题，会替换通知里原来展示 App 名称的地方 |
| builder_id | 否 | 表示通知栏样式ID，Android SDK 可设置通知栏样式，这里根据样式 ID 来指定该使用哪套样式 |
| extras | 否 | 表示扩展字段，接受一个 Hash 对象，以供业务使用 |

###### ios

```ruby
notification.set_ios(
  alert: alert,
  sound: sound,
  badge: badge,
  available: available,
  category: category,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| alert | 是 | 表示通知内容，会覆盖上级统一指定的 alert 信息；内容可以为空字符串，表示不展示到通知栏 |
| sound | 否 | 表示通知提示声音 |
| bandge | 否 | 表示应用角标，把角标数字改为指定的数字；为 0 表示清除 |
| available | 否 | 表示推送唤醒，仅接受 true 表示为 Background Remote Notification，若不填默认是 nil 表示普通的 Remote Notification |
| category | 否 | IOS8才支持。设置 APNs payload 中的 'category' 字段值 |
| extras | 否 | 表示扩展字段，接受一个 Hash 对象，以供业务使用 |

###### 链式调用

```ruby
notification = JPush::Push::Notification.new.
  set_alert(alert).
  set_android(
    alert: alert,
    title: title,
    builder_id: builder_id,
    extras: extras
  ).set_ios(
    alert: alert,
    sound: sound,
    badge: badge,
    available: available,
    category: category,
    extras: extras
  )
```

#### 构建 PushPayload 对象

一个推送对象，表示一条推送相关的所有信息，通知内容体。是被推送到客户端的内容。
**notification 和 message 二者必须有其一，可以二者并存。**
**如果目标平台有 iOS 平台 需要在 options 中通过 apns_production 字段来制定推送环境。True 表示推送生产环境，False 表示要推送开发环境； 如果不指定则为推送生产环境。**

```ruby
# audience 和 notification 对象可按照上面的例子实例化
audience = JPush::Push::Andience.new.set_registration_id(registration_ids)
notification = JPush::Push::Notification.new.set_alert(alert)
```

```ruby
# 初始化 PushPayload 对象
push_payload = JPush::Push::PushPayload.new(
  platform: platform,
  audience: audience,
  notification: notification,
  message: message
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| platform | 是 | 表示推送的平台，其可接受的参数为 'all'（表示推送到所有平台）, 'android' 或 'ios' 或 ['android', 'ios'] |
| audience | 是 | 表示推送的设备，其可接受的参数为 'all' （表示发广播,推送到全部设备） 或者一个 Audience 对象 |
| notification | 否 | 接受一个字符串快速设置最基本的 'alert' 属性，或者一个 Notifcation 对象 |
| message | 否 | 表示应用内消息，仅接受一个字符串来快速设置消息内容本身，要构建复杂的 Message 对象，需使用 PushPayload 的实例方法 set_message |

###### 添加应用内消息

```ruby
push_payload = JPush::Push::PushPayload.new(
  platform: platform,
  audience: audience,
  notification: notification,
).set_message(
  msg_content,
  title: title,
  content_type: content_type,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| msg_content | 是 | 消息内容本身 |
| title | 否 | 消息标题 |
| content_type | 否 | 消息内容类型 |
| extras | 否 | 表示扩展字段，接受一个 Hash 对象，以供业务使用 |

###### 添加短信业务

```ruby
push_payload = JPush::Push::PushPayload.new(
  platform: platform,
  audience: audience,
  notification: notification
).set_sms_message(content, delay_time)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| content | 是 | 表示短信内容，不能超过480个字符 |
| delay_time | 否 | 表示短信发送的延迟时间，单位为秒，不能超过24小时。仅对android平台有效。默认为 0，表示立即发送短信 |

###### 推送可选项

```ruby
options = {
  sendno: no,
  time_to_live: time,
  override_msg_id: msg_id,
  apns_production: true,
  big_push_duration: duration
}

# 参数 options 仅接受一个 Hash 对象，而这个 Hash 对象的键也仅支持上面所示的5种。
push_payload = JPush::Push::PushPayload.new(
  platform: platform,
  audience: audience,
  notification: notification，
  message: message
).set_options(options)
```

参数说明

| 可选项 | 说明 |
| --- | --- |
| sendno | 表示推送序号，纯粹用来作为 API 调用标识，API 返回时被原样返回，以方便 API 调用方匹配请求与返回 |
| time_to_live | 表示离线消息保留时长(秒)，推送当前用户不在线时，为该用户保留多长时间的离线消息，以便其上线时再次推送。默认 86400 （1 天），最长 10 天。设置为 0 表示不保留离线消息，只有推送当前在线的用户可以收到 |
| override_msg_id | 表示要覆盖的消息ID |
| apns_production | 表示APNs是否生产环境，True 表示推送生产环境，False 表示要推送开发环境；如果不指定则为推送生产环境 |
| big_push_duration | 表示定速推送时长(分钟)，又名缓慢推送，把原本尽可能快的推送速度，降低下来，给定的n分钟内，均匀地向这次推送的目标用户推送。最大值为1400.未设置则不是定速推送 |

###### 链式调用

```ruby
push_payload = JPush::Push::PushPayload.new(
  platform: platform,
  audience: audience,
  notification: notification
).set_message(
  msg_content,
  title: title,
  content_type: content_type,
  extras: extras
).set_sms_message(content, delay_time).
set_options(options)
```

#### 推送消息

```ruby
# 仅接受一个 PushPayload 对象参数
pusher.push(push_payload)
```

## Report API

```ruby
reporter = jpush.reporter
```

#### 送达统计

```ruby
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.received(msg_ids)
```

#### 消息统计（VIP专属接口）

```ruby
# 与送达统计 API 不同的是，该 API 提供更多的的统计数据
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.messages(msg_ids)
```

#### 用户统计（VIP专属接口）

```ruby
# 提供近2个月内某时间段的用户相关统计数据：新增用户、在线用户、活跃用户
reporter.users(time_unit, start, duration)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| time_unit | 是 | 表示时间单位，支持：HOUR（小时）、DAY（天）、MONTH（月） （不区分大小写） |
| start | 是 | 接受一个 Time 类的实例，表示统计的起始时间，会根据参数 time_unit 自动的转换成需要的格式。若 time_unit 为 'MONTH' 其格式为yyyy-mm，若 time_unit 为 'DAY' 其格式为 yyyy-mm-dd，若 time_unit 为 'MONTH'，其格式为 yyyy-mm-dd hh，也就是说，会自动根据 time_unit 的不同将 Time 类的实例中用不到的部分去掉 |
| duration | 是 | 表示统计持续的时长，根据参数 time_unit 的不同有不同的取值范围，若 time_unit 为 'MONTH' 其范围为1至2，若 time_unit 为 'DAY' 其范围为1至60，若 time_unit 为 'HOUR'，其范围为1至24，并且只支持输出当天的统计结果，若 duration 超过限定的最大取值，则取最大值。 |

## Schedule API

```ruby
schedules = jpush.schedules
```

#### 构建 Trigger 对象

表示 schedule 任务的触发条件，当前只支持定时任务（single）或定期任务（periodical）

###### 定时任务（single）

```ruby
# 参数 time 接受一个 Time 类的实例
single = JPush::Schedule::Trigger.new.set_single(time)
```

###### 定期任务（periodical)

```ruby
periodical = JPush::Schedule::Trigger.new.set_periodical(start_time, end_time, time, time_unit, frequency, point)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| start_time | 是 | 表示定期任务有效起始时间，接受一个 Time 类的实例 |
| end_time | 是 | 表示定期任务有效过期时间，接受一个 Time 类的实例 |
| time | 是 | 表示触发定期任务的定期执行时间， 其接受一个表示24小时制时间（时分秒）的字符串，例如：'12：07' |
| time_unit | 是 | 表示定期任务的执行的最小时间单位 可选 'day'，'week' 或 'month' |
| frequency | 是 | 与 time_unit 的乘积共同表示的定期任务的执行周期 |
| point | 是 | 接受一个数组，此项与 time_unit 相对应：当 time_unit 为 day 时 point 此项无效；当 time_unit 为 week 时，point 为数组 ['MON','TUE','WED','THU','FRI','SAT','SUN'] 的子数组，表示星期几进行触发；当 time_unit 为 month 时，point 为当前进行月对应的日期， 为数组 ['01', '02' , ..,  '31'] 的子数组 |

#### 构建 SchedulePayload 对象

```ruby
# 参数 trigger 接受一个 Trigger 对象，或者一个 Time 对象快速设置 single 定时任务
# 参数 push_payload 仅接受一个有效的 PushPayload 对象
JPush::Schedule::SchedulePayload.new(name, trigger, push_payload)
```

#### 创建定时任务

```ruby
# 参数 schedule_payload 仅接受一个有效的 SchedulePayload 对象
schedules.create(schedule_payload)
```

#### 获取有效的定时任务列表

```ruby
# 返回当前请求页的详细的 schedule-task 列表，如未指定page则page为1
schedules.tasks(page)
```

#### 获取定时任务详情

```ruby
schedules.show(schedule_id)
```

#### 更新定时任务

**更新操作必须为 'name','enabled','trigger' 或 'push' 四项中的一项或多项**

**定时任务(single)与定期任务(periodical)之间不能进行相互更新，即，原先为single类任务，则不能更新为periodical任务，反之亦然**

**不能更新已过期的schedule任务**

```ruby
schedules.update(schedule_id, name: name, enabled: enabled, trigger: trigger, push: push_payload)
# 例如只更新 name
schedules.update(schedule_id, name: 'jpush')
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| schedule_id | 是 | 表示要更新的定时任务的 id |
| name | 否 | 表示定时任务的名字 |
| enabled | 否 | 表示任务当前状态，布尔值，必须为 true 或 false |
| trigger | 否 | 接受一个 Trigger 对象，或者一个 Time 对象快速设置 single 定时任务 |
| push_payload | 否 | 仅接受一个有效的 PushPayload 对象 |

#### 删除定时任务

```ruby
schedules.delete(schedule_id)
```

## Device API

Device API 用于在服务器端查询、设置、更新、删除设备的 tag,alias 信息，使用时需要注意不要让服务端设置的标签又被客户端给覆盖了

```ruby
devices = jpush.devices
tags = jpush.tags
aliases = jpush.aliases
```

#### 查询设备 (设备的别名与标签)

```ruby
# 获取当前设备的所有属性，包含标签 tags, 别名 alias， 手机号码 mobile
devices.show(registration_id)
```

#### 更新设备 (设备的别名与标签)

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

#### 获取用户在线状态（VIP专属接口）

```ruby
# 参数 registration_ids 为一个表示有效的 registration_id 字符串或者一个最多包含1000个有效的 registration_id 字符串的数组
device.status(registration_ids)
```

#### 查询标签列表

```ruby
# 获取应用的所有标签列表
tags.list
```

#### 判断设备与标签的绑定

```ruby
# 查询某个设备是否在标签下
tags.has_device?(tag_value, registration_id)
```

#### 更新标签 (与设备的绑定的关系)

```ruby
# 为一个标签添加/移除设备
# 参数 registration_ids 为一个表示有效的 registration_id 字符串或者一个最多包含1000个有效的 registration_id 字符串的数组
tags.add_devices(tag_value, registration_ids)
tags.remove_devices(tag_value, registration_ids)
```

#### 删除标签 (与设备的绑定关系)

```ruby
# 删除一个标签，以及标签与设备之间的关联关系, platform 不填默认为所有平台
tags.delete(tag_value, platform)
```

#### 查询别名 (与设备的绑定关系)

```ruby
# 获取指定别名下的设备，最多输出10个, platform 不填默认为所有平台
aliases.show(alias_value, platform)
```

#### 删除别名 (与设备的绑定关系)

```ruby
# 删除一个别名，以及该别名与设备的绑定关系, platform 不填默认为所有平台
aliases.delete(alias_value, platform)
```

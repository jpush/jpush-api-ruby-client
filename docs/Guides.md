# 目录

- [Getting Started](#getting-started)
- [Push API](#push-api)
 - [构建 Audience 对象](#构建-audience-对象)
 - [构建 Notification 对象](#构建-notification-对象)
 - [构建 PushPayload 对象](#构建-pushpayload-对象)
 - [推送消息](#推送消息)
 - [构建 SinglePushPayload 对象](#构建-SinglePushPayload-对象)
 - [批量单推（VIP专属接口）](#批量单推vip专属接口)
- [Report API](#report-api)
 - [送达统计（旧）](#送达统计旧)
 - [送达统计详情（新）](#送达统计详情新)
 - [送达状态查询](#送达状态查询)
 - [消息统计（VIP专属接口，旧）](#消息统计vip专属接口旧)
 - [消息统计详情（VIP 专属接口，新）](#消息统计详情vip-专属接口新)
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
广播外的设备选择方式，有4种类型： tag, tag_and, tag_not, alias, registration_id, **5 种类型至少需要有其一, 这几种类型并存时多项的隐含关系是 AND，即取交集**

```ruby
audience = JPush::Push::Audience.new
audience.set_tag(tag)
audience.set_tag_and(tag_and)
audience.set_tag_not(tag_not)
audience.set_alias(alis)
audience.set_registration_id(registration_ids)

# 链式调用
audience = JPush::Push::Audience.new.
  set_tag(tag).
  set_tag_and(tag_and).
  set_tag_not(tag_not).
  set_alias(alis).
  set_registration_id(registration_ids)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| tag | 否 | 有效的标签字符串或者一个最多包含20个有效的标签字符串的数组 |
| tag_and | 否 | 有效的标签字符串或者一个最多包含20个有效的标签字符串的数组 |
| tag_not | 否 | 有效的标签字符串或者一个最多包含20个有效的标签字符串的数组 |
| alis | 否 | 有效的别名字符串或者一个最多包含1000个有效的别名字符串的数组 |
| registration_ids | 否 | 有效的 registration id 字符串或者一个最多包含1000个有效的 registration id 字符串的数组 |

#### 构建 Notification 对象

若通知的内容在各个平台上，都只有 'alert' 这一个最基本的属性,
则不需要构建 Notifacation 对象，在新建 PushPayload 对象的时候，给 'notication' 参数直接传递表示 alert 的字符串即可，
也可以在 Notifacation 对象中设置 alert 属性。另外 IOS 的 alert 还支持 Hash 对象的参数。
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
  channel_id: channel_id,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| alert | 是 | 表示通知内容，会覆盖上级统一指定的 alert 信息；内容可以为空字符串，表示不展示到通知栏 |
| title | 否 | 表示通知标题，会替换通知里原来展示 App 名称的地方 |
| builder_id | 否 | 表示通知栏样式 ID，Android SDK 可设置通知栏样式，这里根据样式 ID 来指定该使用哪套样式 |
| channel_id | 否 | 不超过1000字节，Android 8.0开始可以进行NotificationChannel配置，这里根据channel ID 来指定通知栏展示效果。 |
| priority | 否 | 表示通知栏展示优先级，默认为 0，范围为 -2～2 ，其他值将会被忽略而采用默认值 |
| category | 否 | 表示通知栏条目过滤或排序，完全依赖 rom 厂商对 category 的处理策略 |
| style | 否 | 表示通知栏样式类型，默认为 0，还有1，2，3 可选，用来指定选择哪种通知栏样式，其他值无效。有三种可选分别为 bigText = 1，Inbox = 2，bigPicture = 3 |
| alert_type | 否 | 表示通知提醒方式， 可选范围为 -1～7 ，对应 Notification.DEFAULT_ALL = -1 或者 Notification.DEFAULT_SOUND = 1， Notification.DEFAULT_VIBRATE = 2， Notification.DEFAULT_LIGHTS = 4 的任意 “or” 组合。默认按照 -1 处理。 |
| big_text | 否 | 表示大文本通知栏样式，当 style = 1 时可用，内容会被通知栏以大文本的形式展示出来，支持 api 16 以上的 rom |
| inbox | 否 | 表示文本条目通知栏样式，接受一个数组，当 style = 2 时可用，数组的每个 key 对应的 value 会被当作文本条目逐条展示，支持 api 16 以上的 rom |
| big_pic_path | 否 | 表示大图片通知栏样式，当 style = 3 时可用，可以是网络图片 url，或本地图片的 path，目前支持 .jpg 和 .png 后缀的图片。图片内容会被通知栏以大图片的形式展示出来。如果是 http／https 的 url，会自动下载；如果要指定开发者准备的本地图片就填 sdcard 的相对路径，支持 api 16 以上的 rom |
| extras | 否 | 表示扩展字段，接受一个 Hash 对象，以供业务使用 |

###### ios

```ruby
notification.set_ios(
  alert: alert,
  sound: sound,
  badge: badge,
  contentavailable: contentavailable,
  mutablecontent: mutablecontent,
  category: category,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| alert | 是 | 表示通知内容，会覆盖上级统一指定的 alert 信息；内容可以为空字符串，表示不展示到通知栏 |
| sound | 否 | 表示通知提示声音 |
| badge | 否 | 表示应用角标，把角标数字改为指定的数字；为 0 表示清除，若不填默认是默认是 +1 |
| contentavailable | 否 | 表示推送唤醒，仅接受 true 表示为 Background Remote Notification，若不填默认是 nil 表示普通的 Remote Notification |
| mutablecontent | 否 | 表示通知扩展，仅接受 true 表示支持 iOS10 的 UNNotificationServiceExtension，若不填默认是 nil 表示普通的 Remote Notification |
| category | 否 | IOS8才支持。设置 APNs payload 中的 'category' 字段值 |
| extras | 否 | 表示扩展字段，接受一个 Hash 对象，以供业务使用 |

###### hmos

```ruby
notification.set_hmos(
  alert: alert,
  title: title,
  category: category,
  intent: intent,
  extras: extras
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| alert | 是 | 这里指定后会覆盖上级统一指定的 alert 信息. 内容不可以是空字符串，否则推送厂商会返回失败 |
| title | 否 | 如果指定了，则通知里原来展示 App 名称的地方，将展示 title。否则使用WebPortal配置的默认title |
| category | 是 | 此字段由于厂商为必填字段，效果也完全依赖 rom 厂商对 category 的处理策略，请开发者务必填写。极光内部对此字段实际未进行必填校验，请开发者按照必填处理。  此字段值对应官方「云端category」取值，开发者通过极光服务发起推送时如果传递了此字段值，请务必按照官方要求传递，官方category分类取值规则也可参考[鸿蒙消息分类标准?](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/push-apply-right-V5)  |
| intent | 是 | 支持跳转到应用首页、deeplink 地址和Action跳转三种类型：1. 跳转应用首页：固定 action.system.home 2. 跳转到 deeplink 地址: scheme://test?key1=val1&key2=val2 3. 跳转到 action 地址: com.test.action。 说明：此字段由于厂商为必填字段，请开发者务必填写。极光内部对此字段实际未进行必填校验，请开发者按照必填处理。 |
| extras | 否 | 这里自定义 JSON 格式的 Key / Value 信息，以供业务使用。 |

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
    contentavailable: contentavailable,
    mutablecontent: mutablecontent,
    category: category,
    extras: extras
  ).set_hmos(
    alert: alert,
    title: title,
    category: category,
    intent: intent,
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
| platform | 是 | 表示推送的平台，其可接受的参数为 'all'（表示推送到所有平台）, 'android' 或 'ios' 或 'hmos' 或 ['android', 'ios', 'hmos'] |
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
)
sms_message = {
  delay_time: delay_time,
  signid: signid,
  temp_id: temp_id,
  temp_para: temp_para,
  active_filter: active_filter
}
push_payload.set_sms_message(sms_message)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| delay_time | 是 | 单位为秒，不能超过 24 小时。设置为 0，表示立即发送短信。该参数仅对 android 、iOS 和 HarmonyOS有效，Winphone 平台则会立即发送短信。 |
| signid | 否 | 签名ID，该字段为空则使用应用默认签名。 |
| temp_id | 是 | 短信补充的内容模板 ID。没有填写该字段即表示不使用短信补充功能。 |
| temp_para | 否 | 短信模板中的参数。 |
| active_filter | 否 | active_filter 字段用来控制是否对补发短信的用户进行活跃过滤，默认为 true ，做活跃过滤；为 false，则不做活跃过滤； |

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
| apns_production | 表示APNs是否生产环境，True 表示推送生产环境，False 表示要推送开发环境；如果不指定则为推送开发环境 |
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

#### 构建 SinglePushPayload 对象

一个单一目标的推送对象，目标为regId或者alias。用于批量单推接口，不同的目标指定不同的推送内容

```ruby
# 初始化 SinglePushPayload 对象
single_push_payload = Push::SinglePushPayload.new(
  platform: platform,
  target: target
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| platform | 是 | 表示推送的平台，其可接受的参数为 'all'（表示推送到所有平台）, 'android' 或 'ios' 或 'hmos' 或 ['android', 'ios', 'hmos'] |
| target | 是 | 推送设备指定。如果是调用RegID方式批量单推接口（/v3/push/batch/regid/single），那此处就是指定regid值；如果是调用Alias方式批量单推接口（/v3/push/batch/alias/single），那此处就是指定alias值。 |
| notification | 否 | 通知内容体。是被推送到客户端的内容。与 message 一起二者必须有其一，可以二者并存 |
| message | 否 | 消息内容体。是被推送到客户端的内容。与 notification 一起二者必须有其一，可以二者并存 |
| sms_message | 否 | 短信渠道补充送达内容体 |
| options | 否 | 推送参数 |

#### 批量单推（VIP专属接口）

如果您在给每个用户的推送内容都不同的情况下，可以使用此接口。

```ruby
# 针对RegID方式批量单推
single_push_payload = Push::SinglePushPayload.new(
  platform: platform,
  target: target
)
@pusher.push_batch_regid([single_push_payload])
```

```ruby
# 针对Alias方式批量单推
single_push_payload = Push::SinglePushPayload.new(
  platform: platform,
  target: target
)
@pusher.push_batch_alias([single_push_payload])
```

## Report API

```ruby
reporter = jpush.reporter
```

#### 送达统计（旧）

```ruby
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.received(msg_ids)
```

#### 送达统计详情（新）

```ruby
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.received_detail(msg_ids)
```

#### 送达状态查询

```ruby
# 参数 msg_id 为消息ID，registration_ids为一个注册ID数组
reporter.status_message(
  msg_id: msg_id,
  registration_ids:
  date: date
)
```

参数说明

| 参数 | 是否必须 | 说明 |
| --- | :---: | --- |
| msg_id | 是 | 消息 id，一次调用仅支持一个消息 id 查询。 |
| registration_ids | 是 | JSON Array 类型，多个registration id 用逗号隔开，一次调用最多支持 1000个。 |
| date | 否 | 查询的指定日期，格式为 yyyy-mm-dd，默认为当天。 |

#### 消息统计（VIP专属接口，旧）

```ruby
# 与送达统计 API 不同的是，该 API 提供更多的的统计数据
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.messages(msg_ids)
```

#### 消息统计详情（VIP 专属接口，新）

```ruby
# 与“送达统计” API 不同的是，该 API 提供更多的针对一个 msgid 的统计数据。
# 与“消息统计” 旧接口相比，此接口获取到的数据更详细，而且如果您的应用开通了Android厂商通道，建议使用此接口。
# 参数 msg_ids 为一个表示有效的 msg_id 字符串或者一个最多包含100个有效的 msg_id 字符串的数组
reporter.messages_detail(msg_ids)
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

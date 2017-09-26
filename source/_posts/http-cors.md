---
title: HTTP访问控制
date: 2017-09-26 09:09:59
categories:
  - HTTP
tags:
  - Web development
  - HTTP
---

## 何为跨域

我们访问的每个网站都有自己的域名，当访问别的域名上的资源时，就发起了一次``跨域HTTP请求``，主要有以下几种情况：

- 资源处于不同的域,同一主域的不同二级域名也是跨域
- 使用不同的协议，如https访问http
- 两个域使用不同的端口

跨域请求有如下几种常见形式：

- 使用XMLHttpRequest或者Fetch访问跨域资源
- Webfont
- Css stylesheet
- Script

从domain-a上访问domain-b上的资源，b上的资源就有可能被domain-a读取或者修改，如果不加控制，domain-b上的资源的安全性就无法保证。这时候就需要应用跨域资源共享（CROS）来控制请求了，从而保证跨域数据传输的安全。

<!--more-->

## 跨域控制

跨域访问控制需要浏览器和服务器一起协同工作才可以做到，主要通过以下办法来实现。

- 服务器声明资源可以被哪些源站访问，如果源站不在名单内，则拒绝访问

- 对于对服务器产生副作用的请求(POST，PUT之类)，浏览器需要发起预检请求来确认服务器是否允许访问，服务器确认允许后才发起实际的请求。

预检请求的流程：
对于需要预检的跨域请求A，浏览器首先发送一个OPTIONS请求，获取跨域服务器支持的所有请求方法，如果服务器返回的支持请求方法中包含A的方法，则发送实际的请求A，否则报错。

### 几种跨域场景

1. 以下请求不会触发CORS预检请求

- 使用以下方法：
  - GET
  - HEAD
  - POST
    仅当POST方法的Content-Type为``text/plain``、``multipart/form-data``、``application/x-www-form-urlencoded``时才不做预检检查
- Fetch规定了一些CORS安全首部字段，以下常见首部不会触发预检请求
  - Accept
  - Accept-Language
  - Content-Language
  - Content-Type(部分值)
  - DPR
  - Downlink
  - Save-Data
  - Viewport-Width
  - Width

  在上述情况下，HTTP请求首部包含了``Origin``字段，值为源站域名，跨域服务器返回的Response首部中包含``Access-Control-Allow-Orign``，里面包含允许访问的源站列表，``*``的话表示任意源站都可以访问该资源。

2. 预检请求

以下情况满足一条，浏览器就需要发送预检请求：
- 使用了以下的HTTP方法：
  - PUT
  - DELETE
  - CONNECT
  - OPTIONS
  - TRACE
  - PATCH
- 请求头中设置了安全首部字段之外的字段，安全首部见上面的列表
- Content-Type不属于以下值:
  - text/plain
  - multipart/form-data
  - application/x-www-form-urlencoded

### 常见的问题

- 使用Fetch API时，服务器自定义的首部拿不到，这时候只能使用XMLHttpRequest代替Fetch API

---
title: gcloud-note
date: 2017-10-01 17:03:52
categories:
    - System
tags:
    - Linux
    - gcloud
---

gcloud程序是谷歌云提供的帮助用户管理谷歌云平台的工具，本文介绍如何在Ubuntu上安装使用它。

## 安装

因为谷歌提供的bash脚本链接被墙了，所以我们需要合理的利用代理来完成安装任务。

```
curl -x proxy_config https://sdk.cloud.google.com | bash // 安装sdk
exec -l $SHELL // 新建一个shell进程替换当前进程
```

## 配置代理服务器

下面配置gcloud的代理，否则它连接不上谷歌云

```
gcloud config set proxy/address proxy_host  // 代理服务器主机名
gcloud config set proxy/port port           // 端口
gcloud config set proxy/type socks5         // 类型，http, http_no_tunnel, socks4, socks5
```

## 初始化

执行``gcloud init``然后按照提示设置选择，shell程序会让你打开一个链接授权，赋值链接到浏览器中完成授权后你会得到一个code，把code复制到shell里就行了，下面选择项目和区域，按照提示信息来就行了。
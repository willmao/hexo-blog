---
title: Linux命令笔记
date: 2017-08-29 23:00:23
updated: 2017-08-31 21:31:00
categories:
    - System
tags:
    - Linux
---

### 系统管理

查看登陆信息

```
    last n  //显示成功的登陆信息
    lastb n //显示失败的登陆
    cd -    //返回上次的目录
```

<!--more-->

### 网络管理

```
    firewall-cmd --add-port=port/protocol [--permanent] //打开指定网络端口
```

#### 开启fastopen功能

fastopen功能可以在建立tcp三次握手的时候就传递有效数据，可以加快网络的访问，以root权限执行以下命令：

```
echo 3 > /proc/sys/net/ipv4/tcp_fastopen
echo 'net.ipv4.tcp_fastopen = 3' >> /etc/sysctl.conf
```

### 软件安装

安装有依赖问题的deb包

```
    sudo dpkg -i 包路径
    sudo apt-get install --fix-broken
```
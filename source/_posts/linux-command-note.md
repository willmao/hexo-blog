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

### 开启Google bbr功能
google bbr是一种网络拥塞控制算法，可以提高网络的速度，在内核4.9中被加入，开启方法：

```
uname -a // 查看内核版本，如果高于4.9则可以，否则只能先升级内核或者手动编译
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

// 检查
sysctl -p //检查配置参数
lsmod | grep bbr // 检查内核模块是否启动bbr
```

### 软件安装

安装有依赖问题的deb包

```
    sudo dpkg -i 包路径
    sudo apt-get install --fix-broken
```
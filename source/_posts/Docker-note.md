---
title: Docker笔记
date: 2017-09-02 15:10:52
categories:
  - Software
tags:
  - Docker
---

> Docker的出现极大的改变了软件的开发和部署，本文记录了Docker使用中遇到的一些问题。

## 连接远程daemon

有时候我们需要在远程机器上面使用Docker daemon,这时候我们需要分别在本地的Docker Client端和Server端做配置。

<!--more-->

### Server端

Docker daemon默认只监听和处理本机client的请求，我们需要配置它监听的host让它可以处理其他机器的请求，Docker支持以下三种格式的请求：

- sock文件请求
- tcp请求
- http请求

我们有以下两种方式来更改默认配置：

- 在daemon启动的命令行中配置
- 在配置文件/etc/docker/daemon.json中配置

Ubuntu 16.10上安装的docker.service中dockerd启动参数是``-H fd://``，这时它只监听本地``unix:///var/run/docker.sock``并且只能被本地client访问，我们可以继续添加一个``-H tcp://machine_ip:port``的参数，这时候就可以让别的机器上的client访问。第二种方式是在dockerd的默认配置文件/etc/docker/daemon.json中配置hosts，配置文件如下：

```
{
  "hosts": [
    "tcp://machine:port",
    "unix:///var/run/docker.sock"
  ]
}
```

> daemon.json中和命令行参数不能冲突，否则将会导致dockerd进程无法启动，同时，你需要确保你的daemon只被受信任的client访问，有关认证的知识本文不做阐述。

### Client端

Docker client会读取DOCKER_HOST环境变量来连接到指定daemon，我们可以用``export DOCKER_HOST=tcp://machine_ip:port``设置环境变量，然后就可以使用远程daemon了。

> 不需要连接远程daemon的时候使用``export DOCKER_HOST=``来置空变量就可以了


---
title: Microsoft Loves Linux
date: 2017-08-28 23:55:05
updated: 2017-09-02 15:51:00
categories:
    - System
tags:
    - System
    - Windows10
---

### 前言

自从2015年换项目组后，在公司一直用Ubuntu进行软件开发，深刻感受到了各种自动化脚本构建的高效和方便，用Linux搭建或者运行代理软件也是非常方便，从此一发而不可收拾，家里的两台电脑也装了Linux。最近用双系统遇到了一个问题，Ubuntu在执行更新之后再进入Windows后鼠标和键盘不工作了，不过Windows10的WSL(Windows Subsystem For Linux)可以解决在Windwos下运行Linux Bash的问题了。本文将记录开启WSL的方法和使用过程中遇到的一些问题。

<!--more-->

### 开启WSL功能

WSL需要Windows10 build 16215.0以及之后的版本，我是用最新版的Windows10，build版本为1703，默认是支持的。
开启步骤：
1. 在启用或者关闭Windows功能中勾选``适用于Windows的Linux子系统(Beta)``功能，安装完成后重启电脑
2. 在``全部设置->更新和安全->针对开发人员``中打开``开发人员模式``
3. 在搜索栏中输入Bash输入``bash``，打开该cmd程序按照提示进行安装并且配置语言环境，或者在应用商店搜索Ubuntu进行安装（我用第一种方法）

安装可能需要数个小时，我是睡觉前安装的，第二天早上看了下装好了，下面就在搜索栏中输入bash，打开``Bash on Ubuntu on Windows``命令行运行bash了。

### 在WSL使用Docker

目前(2017-09-02)WSL中不支持docker-engine的运行，但是我们可以使用docker client来连接到远程或者本机的Windows版docker-engine。

首先安装在WSL中安装docker client:

```
sudo apt-get install docker.io
```

然后通过``export DOCKER_HOST=tcp://ip:port``来配置连接docker daemon的host变量，我们就可以在WSL中使用docker了。

> 关于如何让Docker daemon让远程机器访问，可以参考本人的另外一篇博客{% post_link Docker-note %}
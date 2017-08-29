---
title: linux-command-note
date: 2017-08-29 23:00:23
categories:
    - System
    - Linux
tags:
    - Linux
    - 
---

## Linux命令笔记

### 系统管理
* 查看登陆信息

  显示成功的登陆信息
      ```
      last n
      ```
  显示失败的登陆
  ```
  lastb n
  ```
* 返回上次的目录
    ```
    cd -
    ```
### 网络管理

* 打开指定网络端口
    ```
    firewall-cmd --add-port=port/protocol [--permanent]
    ```
### 软件安装

* 安装有依赖问题的deb包
    ```
    sudo dpkg -i 包路径
    sudo apt-get install --fix-broken
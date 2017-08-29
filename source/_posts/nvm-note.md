---
title: nvm-note
date: 2017-08-29 22:52:14
categories:
    - NodeJS相关
tags:
    - NodeJS
    - nvm
---

## nvm笔记

nvm是node version manager的缩写，可以用它来安装和管理多个node版本, git仓库位置：[Github-nvm](https://github.com/creationix/nvm)

### 安装
  可以使用官方推荐的shell程序来下载和安装

    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

### 常用命令

查看远程仓库中支持的node版本

    nvm ls-remote

使用nvm安装node

    nvm install node // 这会安装最新版node
    nvm install v6.10.2 // 安装指定版本node

切换node版本

    nvm use v7.9.0 // 切换到v7.9.0
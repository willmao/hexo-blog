---
title: Webpack笔记
date: 2017-08-29 22:55:49
categories:
  - Web development
tags:
    - Web tools
    - Webpack
---

### Webpack常见问题

1. Webpack不能watch文件的修改

    问题原因: 系统中打开的文件句柄太多，导致没有足够的watcher可用

    解决办法：增加系统watcher数量，代码如下:

        echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
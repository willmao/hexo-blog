---
title: 翻墙那些事
date: 2017-08-28 10:19:40
categories:
  - System
  - Tools
tags: 
  - GFW
---

## 引言

为什么要翻墙？由于众所周知的原因，在国内访问一些国外的网站速度总是不尽如人意，有些涉及政治、色情的网站就算了，连一些常用的工具网站都被屏蔽，这让我们工作和学习的效率直线下降。
翻墙之前可以先了解一下墙的一些资料：[维基百科-长城防火墙](https://zh.wikipedia.org/zh-cn/%E9%98%B2%E7%81%AB%E9%95%BF%E5%9F%8E)

## 翻墙的思路

由于长城防火墙会在电信骨干网上对网络请求进行分析和拦截，如果我们直接访问被墙的网站，请求就会被防火墙重置掉，所以翻墙的基本原理就是把我们的网络请求加密后先发送的墙外的某台服务器上，
该服务器上的代理软件向目标地址发送请求，再把请求的加密结果转发给我们，这样就避免了请求长城防火墙干扰。

## 常见翻墙手段

目前本人知道或者用过的翻墙工具主要有两种：

- VPN软件
- 代理软件

VPN软件通过全局代理系统网络请求来避开长城防火墙，不过根据最新国家规定，没有经过审批的国内国外VPN软件都是非法的，苹果也在中国区Apple Store中下架了大部分的VPN和代理软件，现在好用的VPN并不是很多，之前我用过ExpressVPN，12刀一个月，还是比较贵的，所以个人更推荐使用代理软件。

常见的代理软件有很多中，其中大部分是通过类socks协议来实现代理功能的，[维基百科-socks](https://zh.wikipedia.org/wiki/SOCKS)。

## 常见的代理软件

目前代理软件主要是通过socks或者类socks协议实现代理功能的，常用的代理软件有如下几种：

### shadowsocks

shadowsocks是用python写的一款socks开源代理软件，它具有非常丰富的功能，而且连接也比较稳定。不过迫于警方的压力，作者已经删除了在github上的项目，目前项目主要由社区维护，并且出现了多个语言版本的分支。社区维护的网站：[shadowsocks网站](https://shadowsocks.org/en/index.html)

### xx-net

xx-net是基于GAE(Google App Engine)的一款软件，它主要利用谷歌的任播技术，只要找到一台谷歌的服务器，就可以利用它代理上网，所以使用它是免费的。项目地址：[xx-net项目](https://github.com/XX-net/XX-Net)

### cow

cow是我非常喜欢的一款代理软件，它兼容ss协议，并且实现了自己的协议——cow协议，它使用go开发，提供安装脚本进行安装，配置也比较简单和灵活。项目地址：[github-cow](https://github.com/cyfdecyf/cow)

## 在Docker安装使用代理软件

Docker极大的改变了软件开发人员的环境配置，它也可以用来快速部署代理软件，我把cow程序和xx-net分别打包进了docker中，大家可以试试。

项目地址：[docker-cow](https://github.com/willmao/docker-cow) & [docker-xxnet](https://github.com/willmao/docker-xxnet)

## 结论

喜欢折腾的同学可以使用各种云商提供的VPS或者ECS自己搭建代理服务器，也可以使用目前台面下的一些人提供的代理服务，推荐一家比较好用的代理：[agentwho](agentho.rocks)。

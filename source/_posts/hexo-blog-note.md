---
title: Hexo博客搭建笔记
date: 2017-09-01 00:31:06
updated: 2017-09-02 01:18:06
categories:
  - Web development
tags:
  - Hexo
  - Travis CI
---

> 最近琢磨着在搭建个个人博客来记录一些学习历程，网上找了一些模板，最后选择了Hexo，主要因为它``快速、简洁且高效``，此外，它提供了数百个主题可以让我们个性化博客系统。

### 内容概述

本文主要包括一下内容：

- 从零开始搭建Hexo博客
- 使用Next主题
- 集成Travis CI自动化部署

<!--more-->

### 搭建Hexo博客

> Hexo博客系统依赖NodeJS和Git，请确保它们已经正确安装。

使用一项技术的最佳方式当然是阅读官方文档，按照[Hexo官方文档](https://hexo.io/zh-cn/docs/)，可以很快搭建好Hexo博客，主要包含一下几个步骤：

- 使用npm安装hexo-cli
- 使用hexo-cli初始化并配置项目
- 写博客
- 发布博客

脚本如下:

```
npm install -g hexo-cli   // 全局安装hexo-cli
hexo-cli init <folder>    // 初始化博客目录
cd <folder>               //进入博客目录
npm install               // 安装项目依赖
```

上面的代码执行完毕后博客目录如下：
```
          .
          ├── _config.yml
          ├── package.json
          ├── scaffolds
          ├── source
          |   ├── _drafts
          |   └── _posts
          └── themes
```

其中,``_config.yml``文件是Hexo博客的核心配置文件，可以在里面设置作者、域名、网站描述等信息，具体请参考[Hexo配置文档](https://hexo.io/zh-cn/docs/configuration.html)

接下来我们可以使用``hexo new post <post_name>``来创建新博客，使用``hexo s[erver]``来启动本地服务器预览博客。

### 安装主题

Hexo自带的主题还是比较简陋的，我们可以使用其他主题，笔者选择了[Next主题](https://github.com/iissnan/hexo-theme-next)。

```
cd <folder>                                                       // 进入博客目录
rm -rf themes/*                                                   // 删除原有主题
git clone https://github.com/iissnan/hexo-theme-next themes/next  // clone next主题
```

每个主题根目录中都有``_config.yml``，这是主题的配置文件，这个里面可以配置GA、评论系统、主题外观等，具体请参考主题配置文档。

### 部署到GitHub Pages

Hexo的配置文件里有deploy选项，Hexo会生成博客的静态文件并放入``.deploy_git``文件夹中，然后将整个文件夹都推送到GitHub项目的指定分支上。

配置文件如下：

```
deploy:
  type: git
  repo: https://github.com/willmao/willmao.github.io.git
  branch: master
```

> 确保你的git命令有权限访问你的GitHub repo(ssh key, email, username要设置好).

部署命令如下：

```
hexo clean && hexo generate && hexo d[eploy]
```

### 利用Travis CI自动化部署

完成上面的配置后我们每次提交新博客，都要手动去deploy，未免有点繁琐，我们可以使用CI工具来自动化完成这些工作。Travis CI是一个被GitHub项目广泛使用的CI工具，很多项目上的Build Status就是从它拿到的Build信息。首先使用GitHub账号登陆和创建Travis账号，然后在博客项目中新建一个``.travis.yml``的配置文件。我的配置文件如下：

```
language: node_js
node_js:
  - "7"
cache:
  directories:
    - "node_modules"

branches:
  only:
    - master

before_install:
  - npm install -g hexo-cli

install:
  - npm install

// 因为没有checin主题项目，所以需要下载并覆盖主题配置文件
before_script:
  - git clone https://github.com/iissnan/hexo-theme-next themes/next
  - cp .theme_config.yml themes/next/_config.yml

script:
  - hexo generate
  - sed -i'' "/^ *repo/s~github\.com~${GITHUB_TOKEN}@github.com~" _config.yml // 替换repo名称，使用token访问repo
  - hexo deploy
```

这里要要解决的一个问题就是权限的问题，如何让CI程序有权限去修改GitHub的项目？
首先需要去GitHub账户设置里的``Personal access tokens``项里生成一个token，生成的时候勾上repo权限，然后到Travis找到项目，新增一个名为``GITHUB_TOKEN``的环境变量，值为刚才生成的token，Travis会在运行的时候让我们的脚本可以访问到这个环境变量，通过``https://{token}@github.com/willmao/willmao.github.io.git``的方式我们的脚本就有权限读写GitHub上的项目了。

> 有些人会担心token被别人看到，引发repo的安全问题，这个不用担心，Travis的log里token会被替换为``secure``显示。

### 注意事项

- 如果你想要自定义域名的话，在``source``文件夹下创建一个名为``CNAME``的文件，把域名写入，配置好域名的DNS到你的GitHub Pages项目就行了。
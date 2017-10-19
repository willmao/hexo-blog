---
title: Grunt从零开始
date: 2017-10-19 23:37:37
categories:
  - Web development
tags:
    - Web tools
    - Grunt
---

Grunt是前端自动化常用的一款工具，它是基于``Task``的任务执行器，本文主要讲述从零开始学习使用Grunt。

## 初始化空项目并安装Grunt

```
mkdir grunt-learn
cd grunt-learn
npm init -y
mkdir -p src/core
touch src/core/index.js
npm install --save-dev grunt
```

> 向``src/core/index.js``中写入一些代码以便后面执行grunt任务

<!--more-->

## 配置Grunt

向``package.json``文件中添加Grunt运行命令脚本，内容如下：

```
  "scripts": {
    "build": "grunt"
  }
```

在根目录中创建一个``Gruntfile.js``的文件，此文件为Grunt默认配置文件。

Grunt配置文件有以下几个部分：
- 包装函数
- 项目和任务配置信息
- 加载Grunt插件和任务
- 自定义任务

## 使用Grunt插件合并JS文件

使用命令``npm install --save-dev grunt-contrib-concat``来安装concat插件，此插件可以帮助我们合并多个文件的代码并输出到指定文件路径中。

### 安装插件
``grunt-contrib-concat``插件可以帮助我们合并JS文件并输出到指定路径，使用以下命令来安装之。

```
npm install --save-dev grunt-contrib-concat
```

### 配置Grunt

在``Gruntfile``中使用以下配置代码：

```
// 包装函数
module.exports = function(grunt) {
  // 任务配置信息
  grunt.initConfig({
    concat: {
      dist: {
        src: ['src/core/index.js'],
        dest: 'dist/built.js',
      }
    }
  });
  // 加载Grunt插件和任务
  grunt.loadNpmTasks('grunt-contrib-concat');
  // 自定义Grunt任务
  grunt.registerTask('default', ['concat:dist']);
};
```

执行``npm run build``运行Grunt任务，Terminal中会打印出如下log：

```
> grunt-learn@1.0.0 build /mnt/d/workspace/grunt-learn
> grunt

Running "concat:dist" (concat) task

Done.
```
查看``dist/built.js``，发现我们在``src/core/index.js``中的代码被输出到了该文件中。

### Grunt配置解析

因为Grunt配置文件是JS文件（也支持Coffeescript文件），所以这让我们拥有了很大的配置灵活性，我们可以使用JS去读取其它配置文件，遍历目录等很多途径去生成配置信息。Grunt配置信息是和其插件名称对应的，比如我们使用了``grunt-contrib-concat``插件，我们在``initConfig``方法中就可以定义一个``concat``的配置对象。每个配置对象有一个Task级的``options``对象，在里面我们可以定义插件的默认配置，此外，Grunt支持为任务创建多个``Target``，每个Target里可以自定义其options配置，Target级的配置会覆盖Task级的配置。

> Grunt中的``src``和``dest``定义在Target顶层而不是在``options``中，如果定义在``options``中则会找不到文件。



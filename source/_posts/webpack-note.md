---
title: Webpack笔记
date: 2017-10-15 22:55:49
categories:
  - Web development
tags:
    - Web tools
    - Webpack
---

webpack 是一个现代 JavaScript 应用程序的模块打包器(module bundler)。当 webpack 处理应用程序时，它会递归地构建一个依赖关系图(dependency graph)，其中包含应用程序需要的每个模块，然后将所有这些模块打包成少量的 bundle - 通常只有一个，由浏览器加载。

## webpack四个核心概念

- 入口文件entry
    webpack创建依赖关系图的起点，可以定义多个入口文件
- 输出文件output
    定义webpack将资源打包到那个路径的那个文件中，一般一个entry文件对应一个output文件
- loader
    webpack把每个资源文件都当作模块处理，它本身只能识别JS，所以需要loader帮助它识别其它类型的资源文件，并转换成模块
- 插件
    用来在打包模块的编译和集合资源的时候执行自定义的操作

<!--more-->

## 初始化环境

### 创建空项目并初始化

```
mkdir webpack-learn
cd webpack-learn
npm init -y
```

### 安装webpack

```
npm install --save-dev webpack
```

### 添加build命令

在根目录下的package.json中的scripts里上添加build命令

```
  "scripts": {
    "build": "webpack"
  }
```

### 添加webpack配置文件

在根目录下创建webpack.config.js文件

```
touch webpack.config.js
```

## 配置webpack

### 基本配置

webpack的配置内容在webpack.config.js中，基本配置如下:

```
module.exports = {
  entry: './src/app.js',
  output: {
    filename: 'app.js',
    path: __dirname + '/dist'
  }
};
```

- entry定义了入口文件为``src/app.js``
- output定义了输出文件名和路径

现在src下面创建app.js文件，然后执行``npm run build``，可以看到命令行中出现了如下的log:
```
> webpack-learn@1.0.0 build /mnt/d/workspace/webpack-learn
> webpack

Hash: 83743640a2da5e7797e4
Version: webpack 3.7.1
Time: 52ms
 Asset     Size  Chunks             Chunk Names
app.js  2.47 kB       0  [emitted]  main
   [0] ./src/app.js 0 bytes {0} [built]
```

webpack在每次编译的时候都生成一个hash值，上面log中的``Hash: 83743640a2da5e7797e4``说明了值的内容，它可以用来区别不同的build。

### 多入口配置

webpack的entry支持多个入口文件，比如我们可以把不同模块分别打包成一个bundle文件，页面只加载自己需要的bundle，这样可以提高页面速度。此外，对于公共的vendor依赖，也可以单独打包，这样可以避免重复打包一些资源文件，节约网络流量。

多入口的基本配置如下：

```
module.exports = {
  entry: {
    core: './src/core/index.js',
    user: './src/user/index.js'
  },
  output: {
    filename: '[name].[hash].js',
    path: __dirname + '/dist'
  }
};
```

上面的配置中，我们创建了两个模块：``core``和``user``，两个模块分别有一个``index.js``的入口文件，output配置中``filename``被设置为``[name].[hash].js``，其中name为entry中设置的名字，hash为此次编译hash值，执行build命令后log如下：

```
> webpack-learn@1.0.0 build /mnt/d/workspace/webpack-learn
> webpack

Hash: 5f8a3d59ab1ee6790d3e
Version: webpack 3.7.1
Time: 58ms
                       Asset     Size  Chunks             Chunk Names
user.5f8a3d59ab1ee6790d3e.js  2.52 kB       0  [emitted]  user
core.5f8a3d59ab1ee6790d3e.js  2.51 kB       1  [emitted]  core
   [0] ./src/core/index.js 35 bytes {1} [built]
   [1] ./src/user/index.js 35 bytes {0} [built]
```

可以看到，webpack为我们打包生成了两个输出文件并在文件名中包含了hash值，这个hash值可以防止浏览器缓存。

### 使用loader



## Webpack常见问题

1. Webpack不能watch文件的修改

    问题原因: 系统中打开的文件句柄太多，导致没有足够的watcher可用

    解决办法：增加系统watcher数量，代码如下:

        echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
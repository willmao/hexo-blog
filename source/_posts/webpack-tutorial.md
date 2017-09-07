---
title: Webpack简明教程
date: 2017-09-05 21:50:59
categories:
  - Web development
tags:
  - Web development
  - Webpack
---

> 现在前端自动化构建已经成为web开发的必备，大部分流行的框架都支持一键式初始化开发环境、自动编译、热加载等功能，本文简要介绍webpack的初级使用方法。
> 文本基于linux环境，使用node和npm进行项目构建，请参考网上文档进行安装。

## 一个简单的例子

### 初始化一个空项目

```
mkdir webpack-demo
cd webpack-demo
npm init -y
```
<!--more-->

初始化好后，项目文件夹中多了一个package.json,里面存放了项目基本信息。

### 安装webpack

```
npm install --save-dev webpack
```

### 加入一些代码文件

```
mkdir src
echo 'console.log("Hello, webpack!")' > src/index.js
```

### 配置webpack

在根目录下面创建一个``webpack.config.js``的配置文件，webpack在build的时候会读取它进行build。

最基本的配置如下：

```
const path = require('path')

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, 'dist')
  }
}
```

上面的配置文件主要包含两个配置：

- entry: 定义入口文件，此处为``src/index.js``
- output: 定义输出文件,此处为``dist/index.js``

### build文件

在根目录下的package.json的``scripts``里加上一条记录，内容如下：

```
"build": "webpack"
```

打开命令行，执行``npm run build``，可以看到命令行中打出如下log:

```
Hash: 350d11f63dd134a67c20
Version: webpack 3.5.5
Time: 46ms
   Asset     Size  Chunks             Chunk Names
index.js  2.49 kB       0  [emitted]  main
   [0] ./src/index.js 18 bytes {0} [built]
```

在``dist``文件夹中可以看到新生成的``index.js``文件，打开该文件，可以看到里面一堆的代码，里面包含了我们源文件中的``console.log("Hello, webpack!")``，这是webpack对我们的代码进行了模块化封装。

### 引用生成的文件

我们还可以在根目录创建一个``index.html``并引入``index.js``文件，其内容如下：

```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <script src="./dist/index.js"></script>
</body>
</html>
```
在浏览器中打开该文件，可以看到控制台输出了``Hello, webpack!``。

至此，一个最基本的webpack配置完成了，这时候的目录结构如下：

```
.
├── dist
|   └── index.js
├── index.html
└── src
    └── index.js
|── package.json
|── package.lock.json
└── webpack.config.js

```
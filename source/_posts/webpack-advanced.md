---
title: webpack-advanced
date: 2017-10-15 20:30:48
categories:
  - Web development
tags:
    - Web tools
    - Webpack
---

在{% post_link webpack-note %}一文中，我们简要叙述了webpack的几个核心概念了基本用法，本文将讲述webpack中的几种高级用法。

<!--more-->

## 本地开发配置

### webpack-dev-server的配置

webpack-dev-server插件可以提供一个简单的web服务器和热重载功能。

首先使用``npm install --save-dev webpack-dev-server``安装。
然后更新webpack.config.js配置文件如下：
```
const WebpackCleanPlugin = require('webpack-clean-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  entry: {
    core: './src/core/index.js',
    user: './src/user/index.js',
    app: './src/app.js'
  },
  output: {
    filename: '[name].[hash].js',
    path: __dirname + '/dist'
  },
  devServer: {
    contentBase: './dist',
    hot: true
  },
  plugins: [
    new WebpackCleanPlugin({
      on: 'emit',
      path: './dist'
    }),
    new HtmlWebpackPlugin({
      title: 'Development'
    })
  ]
};
```
上面我们用了``html-webpack-plugin``，它可以生成一个html文件并加载我们生成的所有bundle文件。devServer的配置中，contentBase指定了web server的根目录，hot表示热加载，一旦我们的代码改动，webpack会重新编译，浏览器中也会自动刷新。
接着，在package.json的scripts中加入start脚本，内容如下：
```
"start": "webpack-dev-server --open"
```
这样执行``npm start``，webpack在编译后会自动启动一个web server并启动浏览器，打开生成的静态页面。

## Code Splitting

Code Splitting是webpack提供的一个令人激动的功能，它可以帮助我们把代码分割为多个bundle，然后可以根据需要加载对应的bundle，从而减少页面加载时间。

webpack中有三种方式实现Code Splitting：
- 入口文件：通过入口文件分割bundle
- 阻止重复打包：通过使用CommonsChunkPlugin删除重复代码
- 动态导入：通过在模块中内联函数动态导入模块

### 入口文件

通过设置多个入口文件，我们可以把代码分割成多个bundle，但是这种做法有两个缺点：
- 如果两个文件中都引用了同一个模块，这个模块将会被重复打包
- 不太灵活，不能在程序逻辑里动态分割代码

### 阻止重复打包

CommonsChunkPlugin插件可以让我们把公共依赖放入一个现存的或者新建的chunk中。
```
const webpack = require('webpack');
const WebpackCleanPlugin = require('webpack-clean-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    core: './src/core/index.js',
    user: './src/user/index.js',
    app: './src/app.js'
  },
  output: {
    filename: '[name].[hash].js',
    path: __dirname + '/dist'
  },
  devServer: {
    contentBase: './dist',
    hot: true
  },
  plugins: [
    new WebpackCleanPlugin({
      on: 'emit',
      path: './dist'
    }),
    new HtmlWebpackPlugin({
      title: 'Development'
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'common'
    })
  ]
};
```
执行编译后可以看到dist文件夹中生成了common.[hash].js文件，如果我们的代码中引用了相同的模块，就会被打包到这个文件中。

### 动态导入

webpack中支持两种动态导入：

- 使用import语法，推荐
- 使用require.ensure，已经废弃

在``src/core/index.js``中引用lodash，代码如下：
```
import(/* webpackChunkName: "lodash" */ 'lodash').then(_ => {
  console.log(_);
})
```

更新webpack.config.js文件如下：
```
const WebpackCleanPlugin = require('webpack-clean-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    core: './src/core/index.js',
    user: './src/user/index.js',
    app: './src/app.js'
  },
  output: {
    filename: '[name].[hash].js',
    chunkFilename: '[name].[chunkHash].js',
    path: __dirname + '/dist'
  },
  devServer: {
    contentBase: './dist',
    hot: true
  },
  plugins: [
    new WebpackCleanPlugin({
      on: 'emit',
      path: './dist'
    }),
    new HtmlWebpackPlugin({
      title: 'Development'
    })
  ]
};
```
执行build可以看到如下log:
```
> webpack-learn@1.0.0 build /mnt/d/workspace/webpack-learn
> webpack

Hash: 6ba13a52341c672a57ee
Version: webpack 3.7.1
Time: 527ms
                         Asset       Size  Chunks                    Chunk Names
lodash.80fbbf9732752be04ae1.js     541 kB       0  [emitted]  [big]  lodash
  user.6ba13a52341c672a57ee.js    5.99 kB       1  [emitted]         user
  core.6ba13a52341c672a57ee.js       6 kB       2  [emitted]         core
   app.6ba13a52341c672a57ee.js    2.51 kB       3  [emitted]         app
                    index.html  350 bytes          [emitted]
   [1] ./src/core/index.js 118 bytes {2} [built]
   [2] ./src/user/index.js 119 bytes {1} [built]
   [3] ./src/app.js 33 bytes {3} [built]
   [4] (webpack)/buildin/global.js 509 bytes {0} [built]
   [5] (webpack)/buildin/module.js 517 bytes {0} [built]
    + 1 hidden module
Child html-webpack-plugin for "index.html":
     1 asset
       [2] (webpack)/buildin/global.js 509 bytes {0} [built]
       [3] (webpack)/buildin/module.js 517 bytes {0} [built]
        + 2 hidden modules
```
可以看到lodash被单独打包到了一个文件中了。

> 上面的配置中，chunkFilename的名字我们使用了``chunkHash``而不是``hash``,chunkHash顾名思义，是针对该chunk的hash值，一般外部的模块代码都不变，其对应的chunkHash也不变，这样不用每次浏览器都更新代码。

---
title: Webpack简单用法
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
    user: './src/user/index.js',
    app: './src/app.js'
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

Hash: 88a10a410debf82db964
Version: webpack 3.7.1
Time: 76ms
                       Asset     Size  Chunks             Chunk Names
user.88a10a410debf82db964.js  2.52 kB       0  [emitted]  user
core.88a10a410debf82db964.js  2.54 kB       1  [emitted]  core
 app.88a10a410debf82db964.js  2.51 kB       2  [emitted]  app
   [0] ./src/core/index.js 68 bytes {1} [built]
   [1] ./src/user/index.js 35 bytes {0} [built]
   [2] ./src/app.js 33 bytes {2} [built]
```

上面的log中，``Hash: 88a10a410debf82db964``为本次编译所对应的hash值，共编译生成了``user``、``core``、``app``三个对应的结果文件（和定义的入口文件对应），``[0]``、``[1]``、``[2]``为解析的文件。

### 使用loader

webpack loader用来对模块的源代码进行转换，它可以使你在``import``模块时预处理文件。看一个在js文件中引用css的例子。
- 创建``src/core/styles/index.css``文件并向其中加入一些css样式。
- 在``src/core/index.js``中使用import语法引用上述css样式文件
- 使用``npm install --save-dev css-loader``安装webpack css-loader
- 更新webpack配置文件如下：

```
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
  module: {
    rules: [
      {
        test: /\.css$/,
        use: 'css-loader'
      }
    ]
  }
};
```
执行``npm run build``可以看到输出如下log:

```
> webpack-learn@1.0.0 build /mnt/d/workspace/webpack-learn
> webpack

Hash: b0d4fadde3ffa2c31daa
Version: webpack 3.7.1
Time: 343ms
                       Asset     Size  Chunks             Chunk Names
core.b0d4fadde3ffa2c31daa.js  5.43 kB       0  [emitted]  core
user.b0d4fadde3ffa2c31daa.js  2.51 kB       1  [emitted]  user
 app.b0d4fadde3ffa2c31daa.js  2.51 kB       2  [emitted]  app
   [0] ./src/core/index.js 65 bytes {0} [built]
   [1] ./src/core/styles/index.css 192 bytes {0} [built]
   [3] ./src/user/index.js 35 bytes {1} [built]
   [4] ./src/app.js 33 bytes {2} [built]
    + 1 hidden module
```
在编译生成的``dist/core.[hash].js``文件中，css样式文件被合并到了里面。
```
exports.push([module.i, "html {\n  margin: 0;\n}", ""]);
```

### 使用插件

插件时webpack的核心功能，插件可以解决loader无法实现的一些事情。插件本质上是具有``apply``属性的JS对象，apply属性会被webpack compiler调用，compiler实例在整个编译过程中都可以被插件访问。

因为插件可以携带参数/选项，所以在webpack配置中，我们需要向plugins传入插件实例，下面为使用``webpack-clean-plugin``清除dist目录的示例。

- 使用命令``npm install --save-dev webpack-clean-plugin``安装插件
- 更新webpack.config.js文件如下：
```
const WebpackCleanPlugin = require('webpack-clean-plugin');

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
  module: {
    rules: [
      {
        test: /\.css$/,
        use: 'css-loader'
      }
    ]
  },
  plugins: [
    new WebpackCleanPlugin({
      on: 'emit',
      path: './dist'
    })
  ]
};
```
执行build命令后，可以看到``dist``文件夹中之前编译生成的文件都被清楚掉了，只保留了此次编译的结果文件。

## Webpack常见问题

1. Webpack不能watch文件的修改

    问题原因: 系统中打开的文件句柄太多，导致没有足够的watcher可用

    解决办法：增加系统watcher数量，代码如下:

        echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
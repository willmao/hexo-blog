---
title: NPM笔记
date: 2017-08-29 22:44:36
catetories:
    - Web tools
    - NPM
tags:
    - npm
    - nodejs
---

### npm命令基本格式

通用命令格式：

    npm config set key value

### 常用NPM命令

替换npm源：

    npm config set registry http://registry.npm.taobao.org

初始化项目，生成package.json：

    npm init //input the previous command and follow the instructions

npm安装包的两种方式：

    npm install [-g] package-name

* 本地安装，只安装在当前项目的node_modules中，被本项目引用
* 全局安装(-g)，全局使用的工具比如grunt可以安装到用户默认的node_modules里

npm卸载安装包：

    npm uninstall [-g] package-name

npm更新安装包：

    npm update [-g] package-name

npm查看安装包依赖：

    npm ls --depth=[depth]

NPM V3依赖解析策略：

* npm依赖包处于顶级目录还是下级目录是由安装顺序决定的，如果顶级目录被某个版本占据，则该版本会一直占据顶级目录。

* 首次对某个包A产生的依赖会将A放在顶级目录，如果有其他包B对A有不同版本的依赖，则将A的新版本放置在包B的下级目录中（行为同npmv2）。

npm整理依赖包：

    npm dedupe

### NPM包版本规则

通用格式为： x.y.z

* 修复bug更新最后以为数字
* 兼容的新feature更新增加中间的数字
* 不兼容的更新增加第一个数字，切换大版本号
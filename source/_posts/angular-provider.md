---
title: angular-provider
date: 2017-10-12 22:16:08
categories:
  - JS
tags:
  - Web development
  - JS
---

AngularJS的一个feature就是它对于依赖注入的支持，比如当我们的代码需要某个service时，我们只需要在依赖参数中声明一下就可以了，AngularJS会帮助我们创建对应的对象并赋值到函数参数中。

AngularJS是怎么知道如何创建该service呢？

<!--more-->

AngularJS中的依赖注入是通过一个$injector的对象来管理的，这个$injector需要一个recipe（处方）的记录簿，来告诉它如何创建各种类型的对象。每条记录都是属于一个AngularJS模块的，一个模块中包含了一个或者多个recipes。AngularJS模块也可以声明依赖于其它模块。

当AngularJS启动某个模块时，它会创建一个新的$injector实例，$injector会创建一个记录簿来记录该模块下的所有recipes和其依赖项。当$injector需要创建对象时，它会查找创建该对象的recipe，分析其依赖，然后根据recipe创建该对象。

## 五种recipe

AngularJS中一共有五种recipe，最核心的是``provider recipe``，其它的都是它的简化版语法糖。

- Value Recipe
  返回一个值
- Factory Recipe
  通过调用函数来返回一个对象或者值
- Service Recipe
  简化版的Factory Recipe，只需要声明名称和依赖参数就可以了
- Provider Recipe
  最基础和核心的recipe，提供一个$get方法，可以让你返回对象或者值，通过application的config函数来注册。在应用程序启动并创建service之前，会初始化所有的provider，初始化完成后service才可以调用provider，初始化完成后就不许允再对providers进行修改了。
- Constant Recipe
  返回一个常量

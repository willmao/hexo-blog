---
title: AngularJS Scope
date: 2017-10-12 14:34:58
categories:
  - JS
tags:
  - Web development
  - JS
---

AngularJS是一个双向数据绑定的框架，其实现的基础就是scope。scope本质上是一个object，相当远data-model，它是view层的唯一数据来源。scope上的属性可以被view层展示，方法可以在view层中绑定到事件上(ng事件而不是DOM事件)。

<!--more-->

## scope工作原理

scope是controller和view层桥梁。在模板链接阶段，directive在scope设置$watch表达式，一旦scope上被watch的属性发生变化，directvie就会被通知到，从而可以让directive去更新DOM。

```
<span>{{username}}</span>
```

当模板中写下上面的代码时，AngularJS会找到这个span元素对应的scope，计算这个scope上的username的值，然后把计算结果插入span元素中，如果你通过一些事件或者其他手段改变了username的值，上面的插值表达式指令也会被通知到，然后更新DOM的数据。

## scope继承结构

Angular application在启动过程中会创建一个root scope,模板中的directive也可以创建新的scope，新的scope被当做child scope存在，这样就形成了一个类似DOM树的scope树。当AngularJS查找scope上的属性和方法时，会从当前scope查找，查不到则查询parent scope，以此类推，直至root scope。
AngularJS中很多directive会隐式创建新的scope，比如ng-repeat。

## scope生命周期

从Angular application启动到结束，scope经历了如下的生命周期：

- 创建
  root scope在app启动期间被创建，在模板链接阶段，directives创建新的子scope
- 注册watches
  在模板链接阶段，directives在scope上设置watches，这些watches在将model值传递给DOM时会被用到
- model变更
  当我们在controller中修改scope上的属性值时，Angular默认为我们调用了scope.$apply方法，只有在$apply方法中修改属性值才会被更新。
- 变更观察
  在$apply方法结尾，Angular在root scope调用了$digest函数，在$digest循环中，所有注册的$watch表达式将会被计算，如果发现和之前的值不同，$watch的callback函数会被执行，DOM将会被更新。
- scope destruction
  当子scope不需要时，通过scope.$destory()来destory它。
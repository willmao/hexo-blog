---
title: AngularJS HTML Compiler
date: 2017-10-12 19:49:44
categories:
  - JS
tags:
  - Web development
  - JS
---

## Overview

AngularJS的HTML Compiler允许开发者自定义HTML语法。它赋予开发者为HTML附加行为、属性甚至是创建自定义HTML元素的能力，AngularJS称这种行为扩展为directives（指令）。

<!--more-->

## Compiler

AngularJS的编译器是一种提供遍历DOM元素属性的服务，编译过程主要发生在两个阶段：

- 编译阶段
  遍历DOM元素，收集所有directives的信息，这个阶段输出是一个链接函数
- 链接阶段
  把directives和scope结合起来并产生一个动态的视图（view），任何对scope model的改动都会反应到view中，任何在view上的用户交互都会反应到scope model中。这让scope model成为view的唯一数据来源。

像ng-repleat这样的指令会为集合中的每个元素复制一个DOM元素，把编译分为编译和链接两个阶段，可以对模板只编译一次，然后对集合中的每个元素进行链接，这样提高了性能。

## 编译过程

需要记住的是，AngularJS操作的的是DOM节点而不是字符串模板，当页面加载的时候，浏览器会自动把HTML转换为DOM树。

HTML编译有三个阶段：

- $compile 遍历所有DOM节点，找到所有directives
  如果编译器发现一个元素上定义了directive，它会把这个指令加入到这个元素的指令列表中，一个元素可以有多个指令
- 所有指令被识别之后，编译器根据指令的优先级排序
  每个指令的compile函数会被执行（有的指令没有定义compile函数），每个compile函数都有一次机会去修改DOM。每个compile函数返回一个链接函数（link function），所有的链接函数会被组合成一个大的函数中。
- $compile 通过调用组合出来的链接函数把模板和scope结合起来，这个过程中会调用各个指令上的链接函数，从而在DOM元素上注册listeners和在scope上设置$watch表达式

上述步骤会在scope和DOM生成动态的绑定，在这个时候，modal上的要给改动会被反应到DOM上面。

## 编译和链接的区别

为什么AngularJS中要把编译过程分为编译和链接两个阶段？这么做是因为当DOM结构发生改变时，可以拆分为两个阶段可以避免对模板的重复编译，从而提高了性能。

来看一个简短的示例：

```
Hello {{user.name}}, you have these actions:
<ul>
  <li ng-repeat="action in user.actions">
    {{action.description}}
  </li>
</ul>
```
上述代码中含有两个directives，一个是``{{user.name}}``插值表达式，一个是``ng-repeat``指令。
当``user.actions``中添加了新的元素时，它需要向DOM中插入一个全新的``<li>``元素，当插入这个``<li>``元素之后，它还需要编译它，因为它包含了插值表达式``{{action.description}}``。一种幼稚的做法是直接插入元素然后编译它，这样会导致每个``<li>``元素都需要编译，如果这个``<li>``里含有复杂的DOM元素，每次都要重新编译一次，这会导致性能很差。相反，如果把编译过程拆为编译和链接两个阶段，编译阶段产生链接函数，链接函数中包含``<li>``元素中所包含的所有指令。集合中新增元素时，只需要创建新的``<li>``元素，然后为它创建一个新的scope，然后在该``<li>``元素上调用之前编译过的链接函数来链接scope和DOM就行了。

> 链接的意思是在DOM元素上面设置listeners和在scope上设置$watch表达式来保持两者同步

## 避免Double Compilation

当一个DOM已经被部分编译又调用了编译函数时，就发生了双重编译，它会带来一系列的问题。一个常见的情况就是在链接函数里调用$compile函数，另一种情况就是对一个已经编译的元素增加指令然后调用$compile函数。详见官方文档。
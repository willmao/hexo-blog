---
title: CSS笔记
date: 2017-08-30 16:13:41
updated_at: 2017-09-06 22:46:41
categories:
  - Web development
tags:
  - Web development
  - CSS3
---

> 最近开发中遇到几个样式问题，发现自己对于CSS3有些用法还不是很熟悉，所以创建这个笔记来记录学习CSS3的一些知识点。

## CSS Background

### background-clip

``background-clip``属性定义了背景填充的区域，我们知道CSS盒模型中元素渲染区域由四个部分组成：

* Content Area
* Padding Area
* Border Area
* Margin Area

<!-- more -->

由于元素背景是不能超过Border Area的，所以该属性由以下几种取值:

```
    border-clip: content-box; // 只填充Content Area
    border-clip: padding-box; // 填充Padding Area和Content Area
    border-clip: border-box;  // 填充Border Area、Padding Area、Content Area
    border-clip: inherit;     // 默认值
```

JSfiddle:

{% jsfiddle williams_mao/g58cLs6x result dark 400 450 %}

## CSS Border

### border-radius

``border-radius``定义了元素的边框``弧度``，我们经常说是圆角，它主要有两种语法。

第一种是我们常见的赋值方式：
```
border-radius: 5px; // 四个角都设置4px的弧度
border-radius: 10px 5px; // 分别设置左上-右下、右上和左下
border-radius: 10px 5px 8px; //分别设置左上、右上和左下、右下
border-radius: 10px 5px 8px 9px; //分别设置左上、右上、右下、左下
```

第二种是设置垂直半径的，语法如下：

```
border-radius: 10px / 5px; // 弧度为10px，垂直半径为5px
border-radius: 10px / 5px 10px; // 弧度为10px， 左上/右下垂直半径为5px，右上左下为10px
// 一共四种情况，分别对应弧度和垂直半径的组合
```

> border-radius在没有border没有设置的情况下也会起作用，它的作用范围收到background-clip控制。

JSfiddle:

{% jsfiddle williams_mao/e9k2jtv9/4%}
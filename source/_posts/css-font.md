---
title: CSS Font
date: 2017-09-07 22:11:05
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

## font-weight

> The font-weight CSS property specifies the weight (or boldness) of the font. The font weights available to you will depend on the font-family you are using. Some fonts are only available in normal and bold.

`font-weight`定义了字体的粗细，它的取值和使用的font-family有关，有些字体只支持normal和bold模式。

<!--more-->

### 语法

font-weight由下面的关键字定义：

- normal 正常值，等价于400
- bold 粗体，等价于700
- lighter 相对于父元素稍微细一点
- bolder 相对于父元素稍微粗一点
- 100-900 用具体粗细数字来定义

> 有时候定义的weight不可用，会使用下面的规则来渲染：

- 大于500，选择最接近的粗体，如果没有，使用最接近的细体
- 小于400，使用最接近的细体，如果没有，使用最近接的粗体
- 等于400, 使用500，如果没有，使用小于400的最小可用值
- 500，使用400，如果400不可用，使用最近接400的细体

总之，如果字体只提供了`normal`和`bold`，100-500为normal,600-900为bold

### 相对值

如果设置font-weight为lighter或者bolder, 由于元素weight继承自父元素，其bolder的font-weight取值为400、700、900中最近接继承值的值，lighter值为100、400、700中最近接继承值的那个值。

JSfiddle示例:

{% jsfiddle williams_mao/qpusdj5d html,css,result %}
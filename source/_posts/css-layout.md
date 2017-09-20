---
title: CSS布局
date: 2017-09-20 08:29:38
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

> CSS可以控制元素在文档中的位置，本文将简要介绍CSS常用的布局手段。

CSS中主要有以下几种布局手段：

- Floats
- Positioning
- CSS tables
- Flexbox
- Grid

<!--more-->

## 默认的文档流

在默认的文档流中，元素按照在源代码中声明的顺序显示，一个一个的堆在其他元素上方。布局技术可以通过以下属性重写默认行为：

- position属性
- float属性
- dispaly属性

## CSS Float

Float属性可以让元素向左侧或者右侧浮动，而不是默认的在元素的上方,Float的主要应用场景是布局列和让文字围绕图片。它有以下几个值：

- left 元素向左浮动
- right 元素向右浮动
- none 不浮动，默认值
- inherit 继承父元素值

## Position

position属性可以让你把元素从默认位置精确地移动到其它位置,它主要有以下几种值：

- static 默认值，元素处于默认位置
- relative 相对定位，元素相对于默认位置定位，这时可以通过top,left等值控制元素位置
- absolute　绝对定位，元素从文档流中脱离出来，看起来自己处于单独的一层，这时它的位置是相对于最近的有显示定位属性的元素，如果没有则相对于html元素
- fixed 和absolute定位相似，不同点在于它始终相对于viewport定位

## CSS tables

年代久远的技术，略过。

## Flexbox

Flexbox解决了以下传统布局技术中比较棘手的问题：

- 元素box垂直居中
- 一列元素高度相同，自动伸缩
- 一列元素平均分配空间

常用属性：

```
display: flex;
align-items: center; //垂直居中
justify-content: center;　// 水平居中
flex-direction: row|column; //flex方向
```

## Grid定位

栅格定位，目前浏览器还没有广泛支持，主要通过列宽度来定位，典型的第三方grid系统为Bootstrap的12列栅格系统，参见[Grid Layout-MDN](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Grids)
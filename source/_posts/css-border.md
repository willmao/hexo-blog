---
title: CSS Border
date: 2017-09-07 20:32:44
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

### border-radius

``border-radius``定义了元素的边框``弧度``，我们经常说是圆角，它主要有两种语法。

第一种是我们常见的赋值方式：
```
border-radius: 5px; // 四个角都设置4px的弧度
border-radius: 10px 5px; // 分别设置左上-右下、右上和左下
border-radius: 10px 5px 8px; //分别设置左上、右上和左下、右下
border-radius: 10px 5px 8px 9px; //分别设置左上、右上、右下、左下
```

<!--more-->

第二种是设置垂直半径的，语法如下：

```
border-radius: 10px / 5px; // 弧度为10px，垂直半径为5px
border-radius: 10px / 5px 10px; // 弧度为10px， 左上/右下垂直半径为5px，右上左下为10px
// 一共四种情况，分别对应弧度和垂直半径的组合
```

> border-radius在没有border没有设置的情况下也会起作用，它的作用范围收到background-clip控制。

JSfiddle:

{% jsfiddle williams_mao/e9k2jtv9 result %}
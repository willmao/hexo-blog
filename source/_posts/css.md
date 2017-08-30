---
title: CSS笔记
date: 2017-08-30 16:13:41
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
---
title: CSS选择器简介
date: 2017-09-11 21:21:17
updated: 2017-09-13 15:35:17
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

> CSS选择器是用来定位我们要设置样式的元素的，掌握CSS选择器是学习CSS的基础，本文将简要叙述CSS中常用的几种选择器。

## CSS选择器分类

CSS选择器可以分为以下几种：

- 简单选择器，包括以下几种
  - 元素选择器
  - id选择器
  - 类选择器

<!--more-->

- 属性选择器，主要有以下几种形式：
  - attr[type] 元素包含type属性
  - attr[type=value] type属性值等于value
  - attr[type~=value] type属性值包含value
  - attr[type expression] type属性值匹配表达式expression
- Pseudo class伪类 如``:hover``
- Pseudo element伪元素 如``::before``
- 组合组合选择器,主要有以下几种：
  - A, B 匹配A或B
  - A B 匹配A的子孙节点中匹配B的元素
  - A > B 匹配A的直系子孙中匹配B的元素
  - A + B 匹配A的直接相邻兄弟节点中匹配B的元素
  - A ~ B 匹配A的所有兄弟节点中匹配B的元素

JSfiddle示例:

{% jsfiddle williams_mao/yn3vy8Lx html,css,result %}

## CSS选择器优先级

CSS选择器优先级主要取决于三个因素：
- Importance,重要性
- Specificity,特殊性
- Source order,源码中出现顺序

### 重要性
使用``!important``定义的属性值拥有最高优先级,该属性值也只能被其他使用``!important``的声明的值替换，不过不建议使用这种方式，因为它打破了级联行为，导致调试很困难。

### 特殊性

> Specificity is basically a measure of how specific a selector is — how many elements it could match.

一般来说，选择器越特殊，它匹配到的元素越少，它的优先级越高。比如，class选择器高于元素选择器，id选择器高于class选择器。选择器的特殊性通过四位数字来量化，规则如下：

- 内联样式为1000
- id选择器100
- 类选择器、属性选择器、伪类选择器10
- 元素选择器、伪元素选择器为1

选择器的最终特殊性值为各个部分应用上述规则结果之和，比如``li > a[href=*"en-US"] > .inline-warning``中有两个元素选择器，一个class选择器、一个属性选择器，所以总和为0022。某个css属性由最高特殊性值的css规则决定。

### 继承

CSS中部分属性值可以继承父元素的值，有些则不会,支持继承的CSS属性值可以设置以下几种值：

- inherit 继承父元素属性值
- initial 使用浏览器默认值
- unset 不设置值，如果默认元素值原生继承父元素值的话则继承，否则使用浏览器默认值
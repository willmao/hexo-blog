---
title: CSS选择器简介
date: 2017-09-11 21:21:17
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

> CSS选择器是用来定位我们要设置样式的元素的，掌握CSS选择器是学习CSS的基础，本文将简要叙述CSS中常用的几种选择器。

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
---
title: CSS Height
date: 2017-09-07 20:32:51
categories:
  - CSS
tags:
  - Web development
  - CSS3
---

## line-height

> The line-height CSS property sets the amount of space used for lines, such as in text. On block-level elements, it specifies the minimum height of line boxes within the element. On non-replaced inline elements, it specifies the height that is used to calculate line box height.

关于`line-height`上面这段话主要说了两点：

- 对于块级元素，line-height定义了元素内最小行盒高度
- 对于非替换的内联元素，line-height用来计算元素行盒高度

<!--more-->

### 赋值语法

- line-height: normal; 取决于了浏览器`user-agent`的设置，根据`font-family`,一般大约1.2
- line-height: number; number*font-size的结果被用来设置行高，推荐方式
- line-height: 20px; 通过固定px来设置
- line-height: 20%; 相对于元素`font-size`的高度

{% note danger %} 
如果通过固定px或者em来设置的话，如果元素的``font-size``被别的css class修改掉的话，行高可能就会出现不是我们预期的效果 
{% endnote %}

JSfiddle示例:

{% jsfiddle williams_mao/n8ppuntk html,css,result %}


{% jsfiddle williams_mao/31w6j16d html,css,result %}

从上面的例子可以看出，加了line-height后，块级元素变高本身变高了，而内联元素和父级div间出现了距离，本身没有变高。
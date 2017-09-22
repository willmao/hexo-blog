---
title: JS中this对象
date: 2017-09-22 09:36:03
categories:
  - Javascript
tags:
  - Web development
  - Javascript
---

JS中的this到底指向谁，这是一个不容易弄清楚的事情，大部分前端开发者都知道一句话，``this总是指向最终调用它的对象``，这句话没有问题，但是如何知道谁调用了this呢。

一个简单的例子：

```
function A() {
	this.name = 'doSomething';
  console.log(this);
  doAnother = function() {
  	console.log(this);
  }
  
  doAnother();
}

let obj = new A();
```

上述代码中，doAnother在构造器函数中被调用了，但是打印出来的this却是window对象，为啥呢？

在大部分情况下，this的值取决于函数是怎么被调用的,也就是取决于调用的上下文，它在函数执行期间不能被修改，下面分情况讨论。

## 全局上下文

在全局上下文中，this总是指向全局对象，不管是否是严格模式。

```
console.log(this === window); // true
```

## 函数上下文

### 简单调用

#### 非严格模式

在非严格模式中，this指向全局对象。

```
function f1() {
  return this;
}

f1() === window; // true
```

#### 严格模式

在严格模式中，this值和它进入函数执行上下文时一致，也就是说，如果this在执行上下文中没有定义，它仍然是未定义的。

```
function f2() {
  'use strict'; // see strict mode
  return this;
}

f2() === undefined;
```

想要传递this值到函数执行上下文，可以用call或者apply函数，其中call函数比apply要快，语法如下：

```
function doSomething() {
  console.log(this);
}

doSomething.call(obj);
doSomething.apply(obj);

```
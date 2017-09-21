---
title: JS基础知识
date: 2017-09-20 13:09:52
categories:
  - Javascript
tags:
  - Web development
  - Javascript
---

## 数据类型

最新ES标准定义了以下数据类型：

- 六种原生数据类型
  - Boolean
  - Null
  - Undefined
  - Number
  - String
  - Symbol (ES6中新增)
- Object

<!--more-->

原生数据类型定义了不可修改的值，JS字符串也是不可修改的。

Boolean，值为true或者false
Null 代表空值
Undefined 代表变量没有赋值
Number JS中Number为64位双精度
String 不可修改的字符串
Symbol 定义一个唯一、不可修改的值，可以用来做对象属性的key

## 创建对象

JS中有以下几种方式创建对象：

1. 通过大括号创建
```
let obj = {};
```
2. 通过Object构造器
```
let obj = new Object();
```
3. 通过构造函数创建
```
function Person() {
  this.name = 'Williams';
  this.displayName = () => {
    console.log(this.name);
  }
}

const person = new Person();
person.displayName();
```

4.　通过Object.create函数
```
function Person() {
  this.name = 'Williams';
  this.displayName = () => {
    console.log(this.name);
  }
}

const person = Object.create(Person);
person.displayName();
```

> Object.create不被IE8支持,应该避免使用它。

## JS prototype

> Prototypes are the mechanism by which JavaScript objects inherit features from one another, and they work differently than inheritance mechanisms in classical object-oriented programming languages.

JS是一门面向对象的编程语言，不过JS中实现继承的机制和Java、C#不一样，它是基于prototype(原型)方式实现继承功能的。JS中是这样实现继承对象继承机制的：

- 每个对象都有一个原型对象，对象从原型对象中继承属性和方法
- 原型是对象，也可以有其原型对象，这样形成从child=>parent的原型链
- 处于顶层的Object对象的原型对象为null

简单的例子：
```
function Person(name) {
  this.name = name;
}

Person.prototype.sayHello = function() {
  console.log(`Hello, ${this.name}`);
}

const p = new Person('Williams');
p.sayHello();
```

> JS中函数也是对象，所以它也可以有原型对象，函数的原型对象存放在它的``prototype``属性中。

> 构造器函数的prototype对象存放了构造对象时需要继承的属性和方法，它是创建对象的一个模板。

JS中对象实例的原型对象存放在其``__proto__``属性中，指向其构造器函数的原型对象，创建对象时实例从其构造器函数的原型对象中继承属性和方法。
上述代码中person对象继承了构造器对象原型上的sayHello方法。

## 对象成员

在访问一个对象的成员时，首先会查找对象本身的成员，如果没有找到，则寻找其原型对象``__proto__``上的成员，如果没有找到，继续向上找，直到原型为null。
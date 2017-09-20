---
title: JS闭包
date: 2017-09-20 14:13:53
categories:
  - Javascript
tags:
  - Web development
  - Javascript
---

> A closure is the combination of a function and the lexical environment within which that function was declared.

闭包是一个函数和声明它的词法环境的结合。

<!--more-->

## 词法作用域

```
function init() {
  var name = 'Williams';

  function displayName() {
    console.log(name);
  }

  displayName();
}

init();
```
上面的``init``函数在执行时会创建函数作用域，在它的作用域内，它创建了局部变量``name``和一个函数``displayName``。displayName函数没有定义自己的局部变量，因为内部函数可以访问外部函数的局部变量，所以这个函数可以显示name值。

## 闭包

```
function makeFn() {
  var name = 'Williams';

  function displayName() {
    console.log(name);
  }

  return displayName;
}

var fn = makeFn();
fn();
```
上面的代码是闭包的一个简单的例子，它可以打印出name变量的值。在有些编程语言中，函数中的局部变量只存在于函数执行期间，函数一执行完成，它就会被释放掉。然而上面的代码可以工作，因为它形成了JS中的闭包，闭包是一个函数和声明它的词法环境的结合。词法环境包含任何函数创建时已经声明的局部变量，displayName函数维护了一个指向init函数词法环境的引用，它可以引用这个词法环境中的局部变量，所以它可以输出name值。

闭包使用的一些场景：

- 封装数据，只暴露指定接口(闭包函数)给外部访问
- Currying，把多参数函数变成单参数函数

一个Currying的例子:
```
function multi(x) {
  return function( y) {
    return x * y;
  }
}

var m5 = multi(5);
var m10 = multi(10);

console.log(m5(2));
console.log(m10(2));
```

## 常见错误

一个使用闭包的常见问题就是在循环中使用闭包，一个例子：
```
function showNames() {
  var names = ['will', 'jack'];
  for (var i = 0; i < names.length; i++) {
    setTimeout(() => {
      console.log(names[i]);
    }, 1000);
  }
}

showNames();
```
程序的输出两个undefined，这是因为setTimeout的处理函数绑定的是showNames的函数作用域，当它执行的时候i值已经经过循环变成了names.length了，所以打印出undefined。

解决办法:

- 使用let声明i，它声明的是块级作用域,i就被绑定在for循环的block中了，所以每次循环都是不同的值
---
title: Microsoft Visual Code配置
date: 2017-08-30 09:33:40
categories:
  - System
  - Tool
tags:
  - System
  - Software
  - Code
---

### 设置语言

用``ctrl+shift+p``组合键搜索``config``，弹出的选项中有配置语言，选中后Code会打开locale.json的文件，在这个文件中我们可以配置Code的显示语言。

    {
      // Defines VSCode's display language.
      // See https://go.microsoft.com/fwlink/?LinkId=761051 for a list of supported languages.
      // Changing the value requires restarting VSCode.
      "locale":"en" // en,en-US,zh-CN
    }

### 基本配置

Code不支持配置同步的功能，所以把配置贴在这里，省的重复工作。

    {
        "editor.tabSize": 2,
        "window.zoomLevel": 0,
        "editor.insertSpaces": true,
        "editor.renderWhitespace": "boundary",
        "markdown.preview.fontFamily": "'Segoe WPC', 'Segoe UI', 'SFUIText-Light', 'HelveticaNeue-Light', sans-serif",
        "extensions.ignoreRecommendations": true,
        "workbench.startupEditor": "newUntitledFile"
    }
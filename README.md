# generator-fanta 

![](http://www.vectors4all.net/preview/fanta-drop-illustration.jpg)

>为yeoman专门制作的fanta饮料，为非专业前端的后端工程师准备，合理整合零碎的web前端页面，SpeedUp前端开发的速度


## Getting Started

### Introduction

以 [Yeoman](http://yeoman.io) 框架为基础的 [generator](http://yeoman.io/authoring/)，fanta 主要的特点

样式支持

* [Bootstrap](http://getbootstrap.com/)

可以选择其中任一种样式语法支持

* [Less](http://lesscss.net/)
* [Sass](http://sass-lang.com/)

字体，这个字体可以省得找图标

* [FontAwesome](http://fortawesome.github.io/Font-Awesome/)

编写脚本的语言支持，义无反顾的支持用 CoffeeScript 来写 JavaScript，高效，简洁，准确

* [CoffeeScript](http://coffeescript.org/)

模板，本框架就用 Jade 了，原因只有一个，相比其他，Jade 最简洁高效

* [Jade](http://jade-lang.com/)

前端模块化, 来完成前端繁琐模块划分工作，不用再各个页面引用不必要的脚本

* [Seajs](http://seajs.org/)



包管理，不用把像 jQuery 和 Bootstrap 的放在代码库里面引用，通过配置来管理各种第三方 CSS 和 Javascript 库

* [Bower](http://bower.io)

前端自动化脚本，这个就不用多介绍了

* [Grunt](http://gruntjs.com)

封装的模块组件

* Smartlist (基于 [list.js](http://listjs.com/) )
* SmartPaginator (基于 [simplePaginator](http://flaviusmatis.github.io/simplePagination.js/) )
* Purl (很好的原生态)
* SmartTree (基于 [jstree](http://www.jstree.com/) (填坑无数，不看文档看代码))
* AutoComplete (基于 [select2](http://ivaynberg.github.io/select2/) )


###Install
安装Yeoman：

```bash
$ npm install -g yo
```

安装generator-fanta
```bash
$ npm install -g generator-fanta
```

生成fanta脚手架
```bash
$ yo fanta
```


## License

MIT

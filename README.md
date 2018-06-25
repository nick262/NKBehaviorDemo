# NKBehaviorDemo
行为是个什么东西呢?行为是一个负责实现一个指定功能的对象，比如你可以有一个实现视差动画的行为。
NKBehavior是基于组合模式来设计的，利用Interface Builder可以零代码实现某些功能。更多关于组合模式和行为的资料请看这篇文章：[iOS 中的行为](http://objccn.io/issue-13-3/)  英文原版：[Behaviors in iOS Apps](https://www.objc.io/issues/13-architecture/behaviors/)

##Demo中使用Behavior实现的功能有：
##1.头部视差效果（零代码实现）

![ParallaxHeader.gif](https://upload-images.jianshu.io/upload_images/1883918-1ad808cce4cc0e51.gif?imageMogr2/auto-orient/strip)

##2.导航栏渐变动画效果

![NavBarGradient.gif](https://upload-images.jianshu.io/upload_images/1883918-03cbd081fe9f23d3.gif?imageMogr2/auto-orient/strip)

##3.视差效果+导航栏渐变效果（组合效果）

![ParallaxHeader+NavBarGradient.gif](https://upload-images.jianshu.io/upload_images/1883918-da4fb2c6249cb151.gif?imageMogr2/auto-orient/strip)

##4.字符输入限制效果

![CharacterLimit.gif](https://upload-images.jianshu.io/upload_images/1883918-1de643e0b82a02ef.gif?imageMogr2/auto-orient/strip)

##5.代码利用行为实现组合效果

![ParallaxHeader+NavBarGradient.gif](https://upload-images.jianshu.io/upload_images/1883918-e97b0eab01ad9932.gif?imageMogr2/auto-orient/strip)


参考链接：
<https://www.jianshu.com/p/27edc90115e0>


# SKLockViewDemo
手势解锁
# SKLockView 手势解锁  
## 原理解读：
* 1 UI 部分 就是 9 个按钮，手指滑动的时候，设置为btn 选中样式，每当手指在屏幕上移动的时候 在去进行连线。
* 2 逻辑部分 记录手势就是记录按钮的连接顺序，可以将按钮的连接顺序保存到本地，每一次登录的时候进行验证就可以了。

## Tips  
自定义的LockView 一定要设置一个被景色 否则的话背景显示为黑色且绘制效果完全呈现给你，
<img src="https://github.com/AlexanderYeah/SKLockViewDemo/blob/master/SKLockViewDemo/1.png" width="300" height="300">  

显示效果  
<img src="https://github.com/AlexanderYeah/SKLockViewDemo/blob/master/SKLockViewDemo/2.png" width="300" height="600"> 


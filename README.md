# HimegariImperialMeister-AutomationScript
DMM游戏《姬狩Imperial Meister》在雷电安卓模拟器上配合叉叉开发助手使用的自动化脚本。
***
## 1、使用说明：
本脚本是本人自用的脚本，并未做任何的适配相关。同时所有的坐标点与取色均采用了绝对值，所以可能会造成无法使用的情况。最近刚知道的叉叉助手内部整顿（跑路）了，所以现在这个脚本能坚持多久我也说不好。然而我又懒得再重新写了所以就先凑合着用吧。
## 2、使用方法：
所需工具：
- 雷电模拟器：使用的是3.96版本，一般情况下我都会更新模拟器的，所以下载最新版即可。
- 叉叉开发集成环境：使用的是2.0.1.7版本，不过目前叉叉官网关闭了下载，如果实在找不到的话使用2.0.1.3版本也应该没有问题。实在不行可以下载我备份的版本（不推荐，因为不是安装包）
- 叉叉开发助手（APK）：安装到雷电模拟器上面的APP，使用的是1.2.13版本。

所需工具下载：均为诚通网盘下载，速度较慢，若可以的话推荐从其它地方下载。
- 雷电模拟器 3.96：[雷电模拟器 3.96（诚通网盘）](http://waternote.ctfile.net/fs/2276132-395546987 "点击跳转")
- 叉叉开发集成环境 2.0.1.7：[叉叉开发集成环境 2.0.1.7（诚通网盘）](http://waternote.ctfile.net/fs/2276132-395546844 "点击跳转")
- 叉叉开发集成环境 2.0.1.3：[叉叉开发集成环境 2.0.1.3（诚通网盘）](http://waternote.ctfile.net/fs/2276132-395546842 "点击跳转")
- 叉叉开发助手（APK） 1.2.13：[叉叉开发助手（APK） 1.2.13（诚通网盘）](http://waternote.ctfile.net/fs/2276132-395547512 "点击跳转")

使用方法：
- 1、安装所有的软件，并将开发助手APK安装到雷电模拟器里面。
- 2、雷电模拟器的分辨率设定为`平板版 1280x720(dpi 240)`。
- 3、在雷电模拟器的网络设置里面将网络设置为桥接模式，桥接你自己的网卡，IP设置为DHCP即可。
- 4、在雷电模拟器上打开开发助手APP，同时授予其root权限。
- 5、打开PC上的叉叉开发集成环境，然后选择导入工程，文件夹选择下载下来的源码`HimegariImperialMeister-AutomationScript`文件夹。
- 6、在叉叉开发集成环境里面单击连接设备（在右边），选择自己的模拟器，然后点击左边的调试按钮。
- 7、根据模拟器上的提示选择相应的内容即可。

## 3、更新履历：
- 2019-08-29：  
1、在battle函数的判断加速是否打开循环中增加了一个判断是否已经胜利的if语句，判断条件为金色的WINNER字母中的W颜色。用于防止由于打的太快，还没有来得及开加速战斗就结束了导致后面的语句无法继续运行的问题，同时需要注意以后整合的时候这个地方是否会造成额外的影响。  
2、增加了一个Version变量，该变量用于在脚本开始时显示该脚本的版本（目前以日期命名），方便查看测试所使用的是否是最新的脚本。  
3、拟定取消战斗中的加速判断，原因是受到的干扰项过多，会导致脚本进程卡住，如果没有什么太好的解决方案的话，可能会在以后的版本里面取消这个功能。  
- 2019-03-27：  
1、增加了等待超时重启函数，默认的等待时间是10分钟（600000毫秒）。  
2、在通用战斗函数中的等待判断是否是小队战斗函数中增加了等待超时函数。  
- 2019-02-09：  
1、延长了启动脚本的重启的等待时间，防止网络过慢导致重启。  
- 2019-01-12：  
1、增加了在周末刷暗素材的功能。  
- 2018-12-08：  
1、在通用战斗函数中增加了战斗失败确认。  
- 2018-12-03：  
1、将体力脚本中的战斗函数替换成通用战斗函数。  
2、在通用战斗函数中增加对于体力脚本的判断，使用二队来进行战斗。  
3、修复通用战斗脚本中判断团体战有快速过图后没有break跳出的bug。  
4、修复体力脚本无返回参数的问题。  
- 2018-11-21：  
1、增加每日活动脚本。  
2、将通用战斗函数中的检测判断是否返回到主界面的严格判断变成了模糊判断，因为每日任务中的红房子的位置与其它的不一样，所以尽量进行了调整，但同时需要额外注意是否会造成误判（因为与红色血条相近）。  
- 2018-11-20：  
1、通用战斗函数基本完成，尝试将活动脚本中的战斗函数替换成通用战斗函数。  
2、在通用战斗函数中添加团体战的技能释放。  
- 2018-11-19：  
1、增加活动脚本开关。  
2、增加判断游戏是否有活动，没有的时候是灰色的。  
3、增加活动脚本对于小队战与团体战的判断。  
4、开始增加通用战斗函数，将逐步实现把所有的战斗内容整合到一起。  


在线网站压力测试平台 Online DDoS
一、	简介
方便用户对自己的网站进行峰值流量压力测试。支持Ping压力测试、GET参数压力测试、POST参数压力测试、UDP洪水及SYN洪水。还支持分布式操作，分布式服务端也基于jsp，不依赖任何jar包，方便部署。在测试的过程中，用户端浏览器也能参与其中。可以让用户全方面的检测自己网站的运行能力。
二、	数据库
1.	ER图
 
		 
三、	主要功能模块及接口定义
1.	checkid.jsp
在用户登录成功后，系统会为用户分配一个唯一的身份识别码。该模块的功能就是在用户使用系统前，验证身份。
身份识别码采用MD5+SHA1加密方式，不可逆向解密，保证安全性。
	接口定义：id      用户email
             Code   身份识别码
	返回值：T   成功
           F   失败
2.	checksafe.jsp
该模块为参数安全检测模块，为了防止SQL注射及XSS跨站脚本攻击。
接口定义：text    需要被检验的参数
返回值：True              合法
        I am very safe!"     非法参数
3.	client.jsp
该模块为流量测试的核心模块及分布式服务端的核心。该模块主要进行Ping、GET、POST、UDP、TCP操作
接口定义：Count         攻击次数
          IsDeath        死亡之Ping的标记
          ThreadCount    线程数
          Paremeter      自定义的GET/POST参数
          Target          测试目标
Port           测试端口
           Sign           测试方式
返回值：返回一个字符串，包含测试方式及次数
4.	clientEdit.jsp
该模块为服务端管理模块。主要是对服务端的增添、删除，验证服务端状态。
接口定义：sign     进行的操作
          Text     添加的客户端
返回值：返回一个字符串，包含操作方式及次数。
5.	getinfo.jsp
该模块为主页提供获取用户信息的功能，用于展示昵称等。
接口定义：email    用户是注册邮箱地址
返回值：返回用户的昵称。
6.	login.jsp
该模块为登录模块，主要是验证用户身份并进行登录。
接口定义：email    用户邮箱地址
          Password 用户的密码
返回值：success  成功
        Error    密码错误
        No      用户不存在
7.	register.jsp
该模块为用户注册模块，主要是为了添加新用户。
接口定义：email    用户邮箱地址
          Password 用户的密码
          Name    用户的昵称
返回值：error    用户已注册
        Success  注册成功
8.	server.jsp
该模块为向服务端转发测试指令的模块，主要是为了向各个服务端转发用户下达的测试指令。
接口定义：paremeter   用户下达的测试参数
返回值：返回值为一个字符串，其中包含转发次数。
9.	tools.jsp
该模块为删首尾空
接口定义：text    需要被处理的文本
返回值：返回被处理好的文本
10.	rouji_list.jsp
该模块为显示数据库中所有的服务端信息。
四、	界面
前端界面总体基于jQuery+Bootstrap4.0框架，大量使用AJAX与服务器进行通讯。

主页
 
带菜单的主页
 
登录
 
注册
 
五、	功能测试
 
通过一个简易的易语言CGI程序，统计客户数和数据数。可基本看出功能运行正常。
六、	实现的难点
1.	Ping操作
通过输入流获取结果，执行cmd命令实现。
 
2.	POST操作
通过调用java.net包中的函数实现
 
3.	UDP连接
通过调用java.net包中的函数实现
 
4.	TCP连接
通过调用java.net包中的函数实现
 

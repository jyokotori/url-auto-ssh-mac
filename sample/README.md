#####如何打开
- 首次使用点击一下myApp.app(因为安全原因,需要确认app来源)
- 打开test.html,输入参数,从浏览器拉起app都是本地完成的,不会把密码发到互联网的,不放心的话你可以自己打包一个app

#####自己打包一个app,这里用的是脚本编辑器,xcode也是可以的
- 查看applescript代码,可以用脚本编辑器打开myApp.app或者myuri.script
- 打开mac系统自带的脚本编辑器,根据需要修改代码,然后导出到有个应用程序的选项
- js代码查看test.html
- app的配置
  - 右击myApp.app显示包内容,有一个`info.list`的文件,用文本编辑器打开它,找到如下内容,这里的`myuri`是自定义的
```applescript
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLName</key>
<string>MYURI DEMO</string>
<key>CFBundleURLSchemes</key>
<array>
<string>myuri</string>
</array>
</dict>
</array>
```

#####这里用了sshpass自动代填密码,安装方法可以Google一下
- 其实这个做法确实很不安全,更好的做法可以用免密登录,或者二次开发sshd服务,用token代替密码
- 不想用sshpass的话,可以考虑用delay延迟后用script模拟键盘输入,然而这也不是一个安全的做法
```applescript
# 比如 delay 3
delay sometime
# 模拟键盘输入
tell application "System Events"
keystroke password
keystroke return
end tell
```

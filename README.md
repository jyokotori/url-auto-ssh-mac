##### Applescript脚本参考了[shuttle](https://github.com/fitztrev/shuttle),go参考了[autossh](https://github.com/islenbo/autossh)

##### 如何打开
- 解压myuri.zip
- 首次使用点击一下myuri.app(因为安全原因,可能需要确认app来源)
- 打开test.html

##### 如何自己打包一个app,这里用的是脚本编辑器
![](https://github.com/kotorimiao/url-auto-ssh-mac/blob/master/sample.png)
- 查看applescript代码,可以用脚本编辑器打开myuri.applescript
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

##### 这里用了go的实现ssh登录,也可以用sshpass之类的密码代填命令
- 其实这个做法确实很不安全,更好的做法可以用免密登录,或者二次开发sshd服务,用token代替密码
- 不想用这类,可以考虑用delay延迟后用applescript模拟键盘输入,然而这也不是一个安全的做法
```applescript
# 比如 delay 3
delay sometime
# 模拟键盘输入
tell application "System Events"
	keystroke password
	keystroke return
end tell
```

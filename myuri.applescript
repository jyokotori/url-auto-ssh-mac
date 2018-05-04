# 直接打开,给个提示
set tip to "It is ready!"
display dialog tip buttons {"OK!"}

on open location this_URL
	# url => myuri://ip/port/username/password
	set x to the offset of ":" in this_URL
	# ip/port/username/password
	set parameters to text from (x + 3) to -1 of this_URL
	# 保存一下苹果脚本文本去限器原值
	set oldDelimiters to AppleScript's text item delimiters
	# 通过苹果脚本文本去限器来分割url
	set AppleScript's text item delimiters to "/"
	# 获得参数list
	set paramList to every text item of parameters
	# 将苹果脚本文本去限器更改回原值
	set AppleScript's text item delimiters to oldDelimiters
	
	# 检查一下参数个数
	set paramCount to the length of paramList
	if paramCount ≠ 4 then
		display alert "参数数量不正确!" as warning
	else
		# 依次取出参数 ip/port/username/password
		set ssh_ip to item 1 of paramList
		set ssh_port to item 2 of paramList
		set ssh_username to item 3 of paramList
		set ssh_password to item 4 of paramList
		# 设置标题
		set customTitle to ssh_username & "@" & ssh_ip
		
		# 用go编译的可执行程序来执行ssh
		set autoSshShell to getAppPath("myuri.app") & "Contents/Resources/autossh " & ssh_ip & " " & ssh_port & " " & ssh_username & " " & ssh_password
		CommandRun(autoSshShell, customTitle)
		
		# 打开新的tab, 并且执行命令
		CommandRun(autoSshShell, customTitle)
		
		#        # ping机制
		#        try
		#            # 检查ip能ping通
		#            set ping to (do shell script "ping -c 2 " & ssh_ip)
		#            -- do something
		#        on error
		#            display alert "连接" & sshIp & "超时,请检查网络配置!" as warning
		#        end try
		
	end if
end open location

-- 打开新的tab页面
on CommandRun(withCmd, theTitle)
	tell application "Terminal"
		if it is not running then
			# 假如是首次运行, 操作window 1
			activate
			set newTerm to do script withCmd in window 1
			set custom title of front window to theTitle
		else
			set windowCount to (count every window)
			if windowCount = 0 then
				# 不是首次运行, 但是没有新窗口
				reopen
				activate
				do script withCmd in window 1
			else
				reopen
				activate
				tell application "System Events"
					tell process "Terminal"
						# 有窗口, 用当前窗口并且打开新的tab页面
						delay 0.2
						keystroke "t" using {command down}
					end tell
				end tell
				activate
				do script withCmd in front window
			end if
			set title displays custom title of front window to true
			set custom title of selected tab of front window to theTitle
		end if
	end tell
end CommandRun

-- 得到app的路径
on getAppPath(appName)
	try
		return POSIX path of (path to application appName)
	on error
		return "not installed"
	end try
end getAppPath

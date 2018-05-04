# ֱ�Ӵ�,������ʾ
set tip to "It is ready!"
display dialog tip buttons {"OK!"}

on open location this_URL
	# url => myuri://ip/port/username/password
	set x to the offset of ":" in this_URL
	# ip/port/username/password
	set parameters to text from (x + 3) to -1 of this_URL
	# ����һ��ƻ���ű��ı�ȥ����ԭֵ
	set oldDelimiters to AppleScript's text item delimiters
	# ͨ��ƻ���ű��ı�ȥ�������ָ�url
	set AppleScript's text item delimiters to "/"
	# ��ò���list
	set paramList to every text item of parameters
	# ��ƻ���ű��ı�ȥ�������Ļ�ԭֵ
	set AppleScript's text item delimiters to oldDelimiters
	
	# ���һ�²�������
	set paramCount to the length of paramList
	if paramCount �� 4 then
		display alert "������������ȷ!" as warning
	else
		# ����ȡ������ ip/port/username/password
		set ssh_ip to item 1 of paramList
		set ssh_port to item 2 of paramList
		set ssh_username to item 3 of paramList
		set ssh_password to item 4 of paramList
		# ���ñ���
		set customTitle to ssh_username & "@" & ssh_ip
		
		# ��go����Ŀ�ִ�г�����ִ��ssh
		set autoSshShell to getAppPath("myuri.app") & "Contents/Resources/autossh " & ssh_ip & " " & ssh_port & " " & ssh_username & " " & ssh_password
		CommandRun(autoSshShell, customTitle)
		
		# ���µ�tab, ����ִ������
		CommandRun(autoSshShell, customTitle)
		
		#        # ping����
		#        try
		#            # ���ip��pingͨ
		#            set ping to (do shell script "ping -c 2 " & ssh_ip)
		#            -- do something
		#        on error
		#            display alert "����" & sshIp & "��ʱ,������������!" as warning
		#        end try
		
	end if
end open location

-- ���µ�tabҳ��
on CommandRun(withCmd, theTitle)
	tell application "Terminal"
		if it is not running then
			# �������״�����, ����window 1
			activate
			set newTerm to do script withCmd in window 1
			set custom title of front window to theTitle
		else
			set windowCount to (count every window)
			if windowCount = 0 then
				# �����״�����, ����û���´���
				reopen
				activate
				do script withCmd in window 1
			else
				reopen
				activate
				tell application "System Events"
					tell process "Terminal"
						# �д���, �õ�ǰ���ڲ��Ҵ��µ�tabҳ��
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

-- �õ�app��·��
on getAppPath(appName)
	try
		return POSIX path of (path to application appName)
	on error
		return "not installed"
	end try
end getAppPath

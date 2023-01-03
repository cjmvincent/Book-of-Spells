$cred = Get-Credential

New-PSDrive -Name "L" -PSProvider FileSystem -Root \\fileshare\techshare$ -Credential $cred

Invoke-Item -Path L:/
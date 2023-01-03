Get-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" -Name IconStreams | Remove-Item

Stop-Process -Name explorer
Start-Process -FilePath C:\Windows\explorer.exe -NoNewWindow

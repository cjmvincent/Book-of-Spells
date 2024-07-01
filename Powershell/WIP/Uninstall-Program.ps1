Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Get-ItemProperty | Where-Object{$._DisplayName -like "example"} | Select-Object -Property DisplayName, UninstallString

Get-WmiObject Win32_Product | Where-Object{$_.Name -like "Eample"}.$_.uninstall()
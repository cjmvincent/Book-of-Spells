$cred  = Get-Credential
$comp = Read-Host -Prompt "What computer would you like to connect to?"
$sess = New-PSSession -ComputerName $comp -Credential $cred

Set-Service -Name WinRM -ComputerName $comp -Status Running
Enter-PSSession -Session $sess
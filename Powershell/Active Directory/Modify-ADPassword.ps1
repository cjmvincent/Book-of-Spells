Import-Module ActiveDirectory

$file = Read-Host -Prompt "What is the path to the list of users you would like to modify the password of?"
$userList = Get-Content -Path $file

#Uncommenting this section will remove the 'force password change' parameter after first log in#
ForEach ($user in $userList) {
Set-ADUser -Identity $user -ChangePasswordAtLogon:$false
}

#Uncommenting this section will reset the user's password to their username#
<#
ForEach ($user in $userList) {
Set-ADAccountPassword -Identity $user -NewPassword (ConvertTo-SecureString -AsPlainText "$user" -Force) -Reset
}
#>
Import-Module ActiveDirectory

$User = Read-Host -Prompt "What user would you like to reset a password for? e.g cvincent"
$newPassword = "Bryan_" + (Get-Date).Year + "!"


Set-ADAccountPassword -Identity $User -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPassword" -Force)
Write-Host "$User's password has been reset to $newPassword."
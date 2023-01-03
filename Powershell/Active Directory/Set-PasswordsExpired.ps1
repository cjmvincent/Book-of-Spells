Import-Module ActiveDirectory

$Users = Get-ADUser -Filter * -OU "OU=Staff,DC=bryan,DC=k12,DC=ga,DC=us" | Where-Object {(!($_.CannotChangePassword -or $_.PasswordNeverExpires))}

ForEach ($User in $Users) {
    Set-ADUser -Identity $User -ChangePasswordAtLogon:$true
}
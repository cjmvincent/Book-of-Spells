Import-Module ActiveDirectory

$Users = Get-ADUser -Filter * -OU "OU=Workstations,DC=cjmvincent,DC=com" | Where-Object {(!($_.CannotChangePassword -or $_.PasswordNeverExpires))}

ForEach ($User in $Users) {
    Set-ADUser -Identity $User -ChangePasswordAtLogon:$true
}
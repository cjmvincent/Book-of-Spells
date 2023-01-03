Import-Module ActiveDirectory

$usersToDisable = Import-Csv -Path c:/users/$env:Username/desktop/DisableUsers.csv

ForEach ($User in $usersToDisable) {
    Disable-ADAccount -Identity $user.Username
}
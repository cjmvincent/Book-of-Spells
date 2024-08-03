Import-Module ActiveDirectory

$Path = "C:\temp\"
$File = "Users.csv"
$UsersToDisable = Import-Csv -Path "$Path\$File"

ForEach ($User in $UsersToDisable) {
    Disable-ADAccount -Identity $User.Username
}
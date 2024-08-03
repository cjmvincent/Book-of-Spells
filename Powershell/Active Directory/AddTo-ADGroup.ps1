Import-Module ActiveDirectory 

$Path = "C:\temp\"
$File = "Users.csv"
$Users = Import-Csv -Path "$Path\$File"
$Group = "ESports_Allow"

ForEach ($User in $Users) {

    Add-ADGroupMember -Identity $Group -Members $_.'username'

}

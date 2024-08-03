Import-Module ActiveDirectory

$Name = "Test"
$DisplayName = "Test" 
$SamAccountName = "Test"
$GroupCat = "Security"
$Scope = "Global"
$Path = "OU=Groups,OU=staff,DC=cjmvincent,DC=com"

New-ADGroup -Name $Name -SamAccountName $SamAccountName -GroupCategory $GroupCat -GroupScope $Scope -DisplayName $DisplayName -Path $Path
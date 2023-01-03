Import-Module ActiveDirectory 

New-ADGroup -Name "Test_A3" -SamAccountName Test_A3 -GroupCategory Security -GroupScope Global -DisplayName "Test A3" -Path "OU=Groups,OU=staff,DC=cjmvincent,DC=com"
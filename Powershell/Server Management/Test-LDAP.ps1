$cred     = Get-Credential
$OUPath = "OU=ServiceAccounts,OU=staff,DC=bryan,DC=k12,DC=ga,DC=us"

$ADSI = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$OUPath", $cred.UserName, $cred.GetNetworkCredential().Password
            )
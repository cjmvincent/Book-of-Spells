Import-Module ActiveDirectory

$ADUsers = Import-CSV -Path C:\users\$env:UserName\desktop\exportdata.csv


ForEach ($User in $ADUsers) {
    $Name = $User.FirstName + " " + $User.LastName
    $Address = $User.StreetAddress
    $City = $User.City
    $PostalCode = $User.ZipCode
    $HomePhone = $User.Phone
    $School = $User.School
    $Position = $User.Position
    $Department = $User.Department
    $OU = "OU=Staff,DC=Bryan,DC=k12,DC=GA,DC=US"
    $UserEmail = $User.FirstName + "." + $User.LastName + "@bryan.k12.ga.us"
    $AccountPassword = "Bryan_" + (Get-Date).Year + "!"
    $ExpirationDate = 
    New-ADUser -Name $Name -DisplayName $Name -StreetAddress $StreetAddress -City $City -PostalCode $ZipCode -HomePhone $HomePhone -EmailAddress $UserEmail -Description $Position -Department $department -SAMAccountName -UserPrincipalName -AccountPassword $AccountPassword -CannotChangePassword:$false -ChangePasswordAtLogon:$true -PasswordNeverExpires:$false -AccountExpirationDate $ExpirationDate
}

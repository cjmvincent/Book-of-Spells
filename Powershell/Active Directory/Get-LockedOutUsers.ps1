Import-Module ActiveDirectory

Search-ADAccount -LockedOut -UsersOnly | Format-Table name, UserPrincipalName
﻿Import-Module ActiveDirectory

Search-ADAccount -LockedOut -UsersOnly | Format-Table Name, UserPrincipalName
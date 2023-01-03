Import-Module ActiveDirectory

Get-ADComputer -Filter {(Enabled -eq $False)} -ResultPageSize 2000 -ResultSetSize $null -Server server.cjmvincent.com -Properties Name, OperatingSystem | Export-CSV $env:CurrentUser\Desktop\DisabledComps.CSV
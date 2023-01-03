Import-Module ActiveDirectory

Get-ADComputer -Filter {OperatingSystem -like "Windows 7*"} -Properties * | Sort LastLogonDate | Select-Object Name, LastLogonDate

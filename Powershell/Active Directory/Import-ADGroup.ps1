Import-Module ActiveDirectory

Import-Csv -Path “C:\Users-To-Add.csv” | ForEach-Object {Add-ADGroupMember -Identity “Test_A3” -Members $_.’User-Name’}
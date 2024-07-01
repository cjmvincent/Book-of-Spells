Import-Module ActiveDirectory 

#Add Users
Import-Csv -Path 'C:\Temp\users.csv' | ForEach-Object { Add-ADGroupMember -Identity “ESports_Allow” -Members $_.'username' }

#Add Computers
#Import-Csv -Path 'C:\Temp\users.csv' | ForEach-Object { Add-ADGroupMember -Identity “ESports_Allow” -Members ($_.'compname'+'$') }
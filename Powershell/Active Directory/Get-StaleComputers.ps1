Import-Module ActiveDirectory 

$date = Get-Date;


#Get Computers
Get-ADComputer -filter * -Properties LastLogonDate,Name,Description,Created|
#filters such as last login
Where-Object {$_.LastLogonDate -lt $date.AddDays(-60)}|
Where-Object {$_.Created -lt $date.AddDays(-60)}| 


#Write results
Select Name,DistinguishedName,Created,LastLogonDate,Description,DNSHostName,Enabled|
export-csv -Path $env:CurrentUser\Desktop\StaleComputers.csv
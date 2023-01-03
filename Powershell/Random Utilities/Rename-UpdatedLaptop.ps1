<#
During feature updates our laptops were renaming themselves. After some investigative work it was determined the culprit
old was an unattend.xml file left over from Dell after a whiteglove deployment.Even after the laptops renamed
themsevles, the netbios stayed the same. The goal here is to query the netbios name, and use that is a variable to
rename itself fixing the laptop's trust issue. 
#>

$cred = Get-Credentials

$laptopName = (Get-WmiObject Win32_ComputerSystem).Name

Rename-Computer -NewName $laptopName -DomainCredential $cred -force

Write-Host "Please configure your hostname: "

Write-Host "Please select your location's appropriate acronym [1-13] :
1. BCES
2. BCHS
3. BCMS
4. BOE
5. GWC
6. LPS
7. MES
8. RHCE
9. RHHS
10. RHMS
11. RHPS
12. FMES"
$site = Read-Host

if ($site -eq "1") { $site = "BCES" }
if ($site -eq "2") { $site = "BCHS" }
if ($site -eq "3") { $site = "BCMS" }
if ($site -eq "4") { $site = "BOE" }
if ($site -eq "5") { $site = "GWC" }
if ($site -eq "6") { $site = "LPS" }
if ($site -eq "7") { $site = "MES" }
if ($site -eq "8") { $site = "RHCE" }
if ($site -eq "9") { $site = "RHHS" }
if ($site -eq "10") { $site = "RHMS" }
if ($site -eq "11") { $site = "RHPS" }
if ($site -eq "12") { $site = "FMES" }

Write-Host "What Year was the Device Purchased:
1. 2013
2. 2014
3. 2015
4. 2016
5. 2017
6. 2018
7. 2019
8. 2020
9. 2021
10. 2022
11. 2023
12. 2024
13. 2025"
$FY = Read-Host

if ($FY -eq "1") { $year = "13" }
if ($FY -eq "2") { $year = "14" }
if ($FY -eq "3") { $year = "15" }
if ($FY -eq "4") { $year = "16" }
if ($FY -eq "5") { $year = "17" }
if ($FY -eq "6") { $year = "18" }
if ($FY -eq "7") { $year = "19" }
if ($FY -eq "8") { $year = "20" }
if ($FY -eq "9") { $year = "21" }
if ($FY -eq "10") { $year = "22" }
if ($FY -eq "11") { $year = "23" }
if ($FY -eq "12") { $year = "24" }
if ($FY -eq "13") { $year = "25" }

$serialNumber = Get-WmiObject -Class Win32_BIOS | Select -ExpandProperty SerialNumber

$computerName = $site + "-" + $year + "-" + $serialNumber
 
$validate = $false
if ($site -eq "") { $ou = "OU=Computers,OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "BCES") { $ou = "OU=Win10, OU=BCES, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "BCHS") { $ou = "OU=Win10, OU=BCHS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "BCMS") { $ou = "OU=Win10, OU=BCMS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "BOE") { $ou = "OU=Win10, OU=BOE, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "GWC") { $ou = "OU=Win10, OU=GWC, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "LPS") { $ou = "OU=Win10, OU=LPS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "MES") { $ou = "OU=Win10, OU=MES, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "RHCE") { $ou = "OU=Win10, OU=RHCEC, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "RHHS") { $ou = "OU=Win10, OU=RHHS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "RHMS") { $ou = "OU=Win10, OU=RHMS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "RHPS") { $ou = "OU=Win10, OU=RHPS, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }
if ($site -eq "FMES") { $ou = "OU=Win10, OU=FMES, OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"; $validate = $true }

if ($validate -eq $false) { Write-Host "You've done something wrong stupid, defaulting to Computers OU."; $ou = "OU=Computers,OU=workstations,DC=bryan,DC=k12,DC=ga,DC=us"}

$localCred = Get-Credential -Message "Please enter the local administrator's credentials:"

Rename-Computer -NewName $computerName -LocalCredential $localCred

Start-Sleep -Seconds 5

$domainCred = Get-Credential -Message "Please enter credential's of a domain administrator:"

Add-Computer -DomainName bryan.k12.ga.us -OUPath $ou -Options JoinWithNewName -Credential $domainCred -LocalCredential $localCred -Force

Write-Host "OU: "$ou
Write-Host "Computer Name: "$computerName

Write-Host "Please restart the device for changes to take effect."
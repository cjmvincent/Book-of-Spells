
$name = Get-WmiObject -Class Win32_ComputerSystem | Select -ExpandProperty Name
$domain = Get-WmiObject -Class Win32_ComputerSystem | Select -ExpandProperty Domain
$manufacturer = Get-WmiObject -Class Win32_ComputerSystem | Select -ExpandProperty Manufacturer
$model = Get-WmiObject -Class Win32_ComputerSystem | Select -ExpandProperty Model
$macAddress = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.servicename -eq "Netwtw06"} | Select -ExpandProperty MACAddress
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select -ExpandProperty SerialNumber
$HDD = [math]::Truncate(((Get-WmiObject win32_logicaldisk | Where {$_.DeviceID -eq "C:"}).size)/1GB)
$RAM = [math]::Truncate((Get-WmiObject -Class win32_physicalmemory | Measure-Object -Property capacity -Sum).sum/1GB)
$productKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
$currentBuild = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$osVersion = (Get-WmiObject -class Win32_OperatingSystem).Caption

Write-Host "
$name.$domain
$manufacturer $model
$macAddress
Service Tag: $serialNumber
$HDD GB HDD / $RAM GB RAM
$osVersion, Build: $currentBuild
Product Key: $productKey
"
#Checking to confirm the gas pump is reachable.
Write-Host "Testing connection to gas pump"
if (Test-NetConnection 10.14.35.52) {
    Write-Host "Gas pump is running."
} elseif (!(Test-NetConnection 10.14.35.52)) {
    Write-Host "Cannot reach gas pump."
}

##################################################################################

#Checking to confirm BCBOE-App1 is reachable.
Write-Host "Testing connection to bcboe-App1"
if (Test-NetConnection -ComputerName BCBOE-APP1) {
    Write-Host "BCBOE-App1 is running."
} elseif (!(Test-NetConnection -ComputerName BCBOE-APP1)) {
    Write-Host "Cannot reach BCBOE-App1."
}

##################################################################################

#Checking to confirm FMU is running on BCBOE-App1.
Write-Host "Confirming FMU is running on BCBOE-App1"
Get-Service -ComputerName BCBOE-App1 -Name imnotsureyet

##################################################################################

#Checking if the FMDownloadService is running on any of the machines of users that access FMU.
Write-Host "Checking if the FMU download service is running on a computer other than BCBOE-App1"
$Person1 = New-Object PSObject
$Person1 | Add-Member -MemberType NoteProperty -Name Name -Value 'Allen Cox'
$Person1 | Add-Member -MemberType NoteProperty -Name Computer -Value boe-trans-s-101

$Person2 = New-Object PSObject
$Person2 | Add-Member -MemberType NoteProperty -Name Name -Value 'Sonya ONeal'
$Person2 | Add-Member -MemberType NoteProperty -Name Computer -Value boe-trans-s-102

$Person3 = New-Object PSObject
$Person3 | Add-Member -MemberType NoteProperty -Name Name -Value '????'
$Person3 | Add-Member -MemberType NoteProperty -Name Computer -Value boe-trans-s-103

$Users = @($Person1, $Person2, $Person3)

foreach ($user in $users) {
    Get-Service -ComputerName $user.computer -Name FMDownloadService
}

##################################################################################
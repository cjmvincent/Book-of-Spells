Import-Module importexcel

$Path = "C:\temp"
$File = "named_devices.xlsx"
$Worksheet = "Sheet1"

$Devices = Import-Excel -Path $Path\$File  -Worksheet $Worksheet

$ReachableIPs = @()
$UnreachableIPs = @()

foreach ( $device in $Devices ) {

    #$IP = $device.IPAddress

    Write-Host "Testing $device.HostName"

    if ( Test-Connection -ComputerName $device.IPAddress -Count 1 -Quiet ) {
        $ReachableIPs += $device
    } else {
        $UnreachableIPs += $device
    }
}

#Write-Host "These devices were reachable:"
#$IPs | Format-Table -AutoSize

Write-Host "These devices were not reachable:"
$UnreachableIPs | Format-Table -AutoSize
cd C:\temp
$Devices = ( Import-Csv -Path .\trash.csv )
$GW = @()
$Unreachable = @()
foreach ( $device in $Devices ) {
    if ( Test-Connection -ComputerName $device.IPAddress -Count 2 ) {
        $GW += $device
    } elseif ( !( Test-Connection -ComputerName $device.IPAddress -Count 2) ) {
        $Unreachable += $device
    }
}
Write-Host "These devices were reachable at:"
$GW | Format-Table -AutoSize
Write-Host "These devices were not reachable:"
$Unreachable | Format-Table -AutoSize

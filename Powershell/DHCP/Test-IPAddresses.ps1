Import-Module importexcel

$Source_Path = "C:\temp"
$Source_File = "dhcp_stuff.xlsx"
$Source_Worksheet = "Hosts"

$Devices = Import-Excel -Path $Source_Path\$Source_File  -Worksheet $Source_Worksheet

$Dest_Path = "C:\temp"
$Dest_File = "dhcp_stuff.xlsx"
$Reachable_Worksheet = "Reachable"
$Unreachable_Worksheet = "Unreachable"


foreach ( $device in $Devices ) {

    $Device = [PSCustomObject]@{
        'HostName' = $device.HostName;
        'IPAddress' = $device.IPAddress;
        'ClientID' = $device.ClientID
    }

    Write-Host "Testing $($Device.HostName)"

    if ( Test-Connection -ComputerName $Device.IPAddress -Count 1 -Quiet ) {
        $Device | Export-Excel -Path $Dest_Path\$Dest_File -WorksheetName $Reachable_Worksheet -Append
        #Pause momentarily so script doesn't run faster than the spreadsheet can be written to
        Start-Sleep -Milliseconds 500
        #$Reachable_IPs += $Device
    } else {
        $Device | Export-Excel -Path $Dest_Path\$Dest_File -WorksheetName $Unreachable_Worksheet -Append
        #Pause momentarily so script doesn't run faster than the spreadsheet can be written to
        Start-Sleep -Milliseconds 500
        #$Unreachable_IPs += $Device
    }

}
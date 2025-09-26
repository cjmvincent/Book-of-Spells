Import-Module ImportExcel

$Source_Path = "C:\temp"
$Source_File = "dhcp.xlsx"
$Source_Worksheet = "Printers"

# Load devices once
$Devices = Import-Excel -Path "$Source_Path\$Source_File" -WorksheetName $Source_Worksheet

# Create a HashSet of device IPs for fast lookup
$DeviceIPs = [System.Collections.Generic.HashSet[string]]::new()
foreach ($device in $Devices) {
    $DeviceIPs.Add($device.IPAddress.ToString())
}

$Dest_Path = "C:\temp"
$Dest_File = "dhcp.xlsx"
$Dest_Worksheet = "Found"

# Buffer results in memory
$Global:Data = @()

function Find-NamedDevices {
    param($Server)

    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server

    foreach ($IP in $All_IPs) {
        if ($DeviceIPs.Contains($IP.IPAddress.ToString())) {
            $Global:Data += [PSCustomObject]@{
                Hostname  = $IP.Hostname
                ClientID  = $IP.ClientID
                IPAddress = $IP.IPAddress
            }
        }
    }
}

$servers = @(
    "bcboe-fs2"
    "bcboe-fs3"
)

foreach ($server in $servers) {
    Find-NamedDevices -Server $server
}

# Write all matched results at once
if ($Global:Data.Count -gt 0) {
    $Global:Data | Export-Excel -Path "$Dest_Path\$Dest_File" -WorksheetName $Dest_Worksheet -ClearSheet
}

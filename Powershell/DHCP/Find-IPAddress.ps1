Import-Module ImportExcel

$Source_Path = "C:\temp"
$Source_File = "printers.xlsx"
$Source_Worksheet = "Status"

# Load devices once
$Devices = Import-Excel -Path "$Source_Path\$Source_File" -WorksheetName $Source_Worksheet

# Create a dictionary keyed by IP address for fast lookup and access to PrinterName
$DeviceMap = @{}
foreach ($device in $Devices) {
    $DeviceMap[$device.IPAddress.ToString()] = $device
}

$Dest_Path = "C:\temp"
$Dest_File = "printers.xlsx"
$Dest_Worksheet = "Get-MACs"

# Buffer results in memory
$Global:Data = @()

function Find-NamedDevices {
    param($Server)

    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server

    foreach ($IP in $All_IPs) {
        $ipString = $IP.IPAddress.ToString()
        if ($DeviceMap.ContainsKey($ipString)) {
            $device = $DeviceMap[$ipString]
            $Global:Data += [PSCustomObject]@{
                PrinterName = $device.PrinterName
                Server = $device.Server
                Driver = $device.Driver
                PortName = $device.PortName
                Hostname    = $IP.Hostname
                ClientID    = $IP.ClientID
                IPAddress   = $IP.IPAddress
                Status   = $device.Status
                DHCPServer  = $Server
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
    $Global:Data | Export-Excel -Path "$Dest_Path\$Dest_File" -WorksheetName $Dest_Worksheet -ClearSheet -AutoSize
}

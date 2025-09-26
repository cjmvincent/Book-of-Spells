Import-Module importexcel

$Source_Path = "C:\temp"
$Source_File = "dhcp.xlsx"
$Source_Worksheet = "Printers"

$Devices = Import-Excel -Path $Source_Path\$Source_File  -Worksheet $Source_Worksheet

$Dest_Path = "C:\temp"
$Dest_File = "dhcp.xlsx"
$Dest_Worksheet = "Found"

$Global:Data = @()
Function Find_NamedDevices ($Server){

    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($Device in $Devices){
            If ($IP.IPAddress -like "*$($Device.IPAddress)*"){
                $Device = [PSCustomObject]@{
                    Hostname = $IP.Hostname;
                    ClientID = $IP.ClientID;
                    IPAddress = $IP.IPAddress
                }
            $Device | Export-Excel -Path $Dest_Path\$Dest_File -WorksheetName $Dest_Worksheet -Append
            }
        }
    }
}

$servers = @(
    "bcboe-fs2"
    "bcboe-fs3"
)

foreach ($server in $servers) {
    Find_NamedDevices -Server $server
}

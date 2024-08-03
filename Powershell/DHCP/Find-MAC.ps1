Import-Module -Name DHCPServer

$addresses = @(
    "00-18-85-52-fc-df"

)

$Global:Data = @()

Function Find_MACs ($Server){
    
    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($address in $addresses){
            If ($IP.ClientID -like "$address"){
                $device = [PSCustomObject]@{
                    Hostname = $IP.Hostname;
                    ClientID = $IP.ClientID;
                    IPAddress = $IP.IPAddress
                }
                $Global:Data += $device
            }
        }
    }
}

$servers = @(
    "bcboe-fs2"
    "bcboe-fs3"
)

foreach ($server in $servers) {
Find_MACs -Server $server
}

$Global:Data |Format-Table -AutoSize
#$Global:Data | Out-File -FilePath C:\temp\trash.csv
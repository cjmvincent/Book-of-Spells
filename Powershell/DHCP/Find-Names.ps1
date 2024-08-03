$names = @("cvincent","swilliams")

$Global:Data = @()
Function Find_DeviceNames ($Server){
    
    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($Name in $names){
            If ($IP.Hostname -like "*$Name*"){
                $GW = [PSCustomObject]@{
                    Hostname = $IP.Hostname;
                    ClientID = $IP.ClientID;
                    IPAddress = $IP.IPAddress
                }
                $Global:Data += $GW
            }
        }
    }
}
Find_DeviceNames -Server "bcboe-fs2"
Find_DeviceNames -Server "bcboe-fs3"
$Global:Data |Format-Table -AutoSize
#$Global:Data | Out-File -FilePath C:\temp\trash.csv
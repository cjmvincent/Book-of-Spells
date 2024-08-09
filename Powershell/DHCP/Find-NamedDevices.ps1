$names = @("Avigilon")
$Global:Data = @()
Function Find_NamedDevices ($Server){
    
    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($Name in $names){
            If ($IP.Hostname -like "*$Name*"){
                $Device = [PSCustomObject]@{
                    Hostname = $IP.Hostname;
                    ClientID = $IP.ClientID;
                    IPAddress = $IP.IPAddress
                }
                #$Global:Data += $Device
                $Device | Export-Excel -Path "C:\temp\named_devices.xlsx" -WorksheetName "Sheet1" -Append
            }
        }
    }
}
Find_NamedDevices -Server "bcboe-fs2"
Find_NamedDevices -Server "bcboe-fs3"
#$Global:Data |Format-Table -AutoSize
#$Global:Data | Out-File -FilePath "C:\Users\$env:USERNAME\Downloads\avigilon.xlsx"
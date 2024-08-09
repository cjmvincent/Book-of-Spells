Import-Module -Name DhcpServer

$Scope = "10.5.32.0"
$Server = "bcboe-fs2"

$All_IPs = Get-DhcpServerv4Scope -ComputerName $Server -ScopeId $Scope | Get-DhcpServerv4Lease -ComputerName $Server


Foreach ( $IP in $All_IPs ) {

    Write-Host "Processing $($IP.IPAddress)"

    $Entry = [PSCustomObject]@{

        'IPAddress' = $IP.IPAddress;
        'ScopeId' = $IP.ScopeId;
        'ClientId' = $IP.ClientId;
        'HostName' = $IP.HostName;
        'AddressState' = $IP.AddressState;
        'LeaseExpiryTime' = $IP.LeaseExpiryTime

    }

    $Entry | Export-Excel -Path "C:\temp\device_ips.xlsx" -WorksheetName "something" -Append
    Start-Sleep -Milliseconds 500

}
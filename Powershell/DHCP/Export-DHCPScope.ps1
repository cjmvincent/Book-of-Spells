Import-Module -Name DhcpServer

#Server and scope to pull leases from
$Scope = "10.5.32.0"
$Server = "bcboe-fs2"

#All leases from above set vars
$All_IPs = Get-DhcpServerv4Scope -ComputerName $Server -ScopeId $Scope | Get-DhcpServerv4Lease -ComputerName $Server

#File to write results to
$Path = "C:\temp"
$File = "device_ips.xlsx"
$Sheet = "Name"

Foreach ( $IP in $All_IPs ) {

    Write-Host "Processing $($IP.IPAddress)"

    #Create custom object to hold pertinent info
    $Entry = [PSCustomObject]@{

        #Be sure to create a template excel file with the needed headers you see below
        'IPAddress' = $IP.IPAddress;
        'ScopeId' = $IP.ScopeId;
        'ClientId' = $IP.ClientId;
        'HostName' = $IP.HostName;
        'AddressState' = $IP.AddressState;

    }

    #Append var to our spreadsheet for later use
    $Entry | Export-Excel -Path $Path\$File -WorksheetName $Sheet -Append
    #Pause momentarily so script doesn't run faster than the spreadsheet can be written to
    Start-Sleep -Milliseconds 500

}

Write-Host "Finished."
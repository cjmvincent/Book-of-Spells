Import-Module -Name DhcpServer

#Server and scope to pull leases from
$Scope = "10.150.0.0"
$Server = "10.8.0.31"

#All leases from above set vars
$All_IPs = Get-DhcpServerv4Scope -ComputerName $Server -ScopeId $Scope | Get-DhcpServerv4Lease -ComputerName $Server

#File to write results to
$Path = "C:\temp"
$File = "dhcp_stuff.xlsx"
$Sheet = "Leases"

Foreach ( $IP in $All_IPs ) {

    #Write-Host "Processing $($IP.IPAddress)"

    #Create custom object to hold pertinent info
    $Entry = [PSCustomObject]@{

        #Be sure to create a template excel file with the needed headers you see below
        'IPAddress' = $IP.IPAddress;
        'ScopeID' = $IP.ScopeId;
        'ClientID' = $IP.ClientId;
        'HostName' = $IP.HostName;
        'AddressState' = $IP.AddressState;

    }

    #Append var to our spreadsheet for later use
    $Entry | Export-Excel -Path $Path\$File -WorksheetName $Sheet -Append
    #Pause momentarily so script doesn't run faster than the spreadsheet can be written to
    Start-Sleep -Milliseconds 500

}

Write-Host "Finished."
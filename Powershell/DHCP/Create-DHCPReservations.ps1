Import-Module -Name ImportExcel
Import-Module -Name DHCPServer

$Input_Path = "C:\temp"
$Input_File = "dhcp_stuff.xlsx"
$Input_Sheet = "Reservations"

$addresses = Import-Excel -Path $Input_Path\$Input_File -WorksheetName $Input_Sheet

foreach ( $address in $addresses ) {
    Write-Host "Creating address for $($address.HostName) $($address.ClientID)"
    Add-DhcpServerv4Reservation -ComputerName $address.DHCPServer -ScopeId $address.ScopeID -IPAddress $address.IPAddress -Name $address.Hostname -ClientId $address.ClientID -Description $address.Description
}
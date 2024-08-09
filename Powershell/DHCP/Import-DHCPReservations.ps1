# csv should have the following headers: dhcpserver,scopeid,ipaddr,name,mac,description
# example: 10.10.10.0,10.10.10.10,Computer1,1a-1b-1c-1d-1e-1f,Reserved for Computer

$path = "C:\temp"
$file = "dhcpreservations.xlsx"
$sheet = "Sheet1"

$reservations = Import-Excel -Path $path\$file -WorksheetName $sheet

foreach ( $reservation in $reservations ) {
    Write-Host "Creating reservation for $($reservation.Hostname) $($reservation.ClientID)"
    Add-DhcpServerv4Reservation -ComputerName $reservation.DHCPServer -ScopeId $reservation.ScopeID -IPAddress $reservation.IPAddress -Name $reservation.Hostname -ClientId $reservation.ClientID -Description $reservation.Description
}
# csv should have the following headers: dhcpserver,scopeid,ipaddr,name,mac,description
# example: 10.10.10.0,10.10.10.10,Computer1,1a-1b-1c-1d-1e-1f,Reserved for Computer

$path = C:\temp
$file = dhcpreservations.csv

$reservations = Import-Csv -Path "$path\$file"

foreach ( $reservation in $reservations ) {
    Write-Host "Creating reservation for $reservation.name $reservation.mac"
    Add-DhcpServerv4Reservation -ComputerName $reservation.dhcpserver -ScopeId $reservation.scopeid -IPAddress $reservation.ipaddr -Name "$reservation.name" -ClientId "$reservation.mac" -Description "$reservation.description"
}
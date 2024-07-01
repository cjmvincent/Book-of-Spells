$path = "C:\temp"
$file = "dhcpexport.csv"

Get-DhcpServerv4Reservation -ComputerName bcboe-fs2 -ScopeId 10.11.0.0 | Export-CSV "$path\$file" -Encoding UTF8 -Force -NoTypeInformation

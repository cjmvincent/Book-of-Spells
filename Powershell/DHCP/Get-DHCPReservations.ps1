Import-Module -Name ImportExcel

$path = "C:\temp"
$file = "dhcpexport.csv"
$sheet = "Sheet1"
$scopeID = "10.150.0.0"
$server =  "10.8.0.31"

Get-DhcpServerv4Reservation -ComputerName $server -ScopeId $scopeID | Export-CSV "$path\$file" -Encoding UTF8 -Force -NoTypeInformation

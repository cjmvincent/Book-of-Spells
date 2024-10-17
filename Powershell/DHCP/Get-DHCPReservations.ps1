Import-Module -Name ImportExcel

$path = "C:\temp"
$file = "dhcpexport.csv"
$sheet = "Sheet1"
$scopeID = ""
$server =  ""

Get-DhcpServerv4Reservation -ComputerName $server -ScopeId $scopeID | Export-CSV "$path\$file" -Encoding UTF8 -Force -NoTypeInformation

$dhcpserver = Read-Host -Prompt "Are you making a reservation for North Bryan or South Bryan?
1. North Bryan
2. South Bryan
"
if ($dhcpserver -ne ("1" -or "2")) {Write-Host "You have entered an invalid entry."}
if ($dhcpserver -eq "1") {$dhcpserver = "bcboe-fs2.bryan.k12.ga.us"}
if ($dhcpserver -eq "2") {$dhcpserver = "bcboe-fs3.bryan.k12.ga.us"}


$MAC = Read-Host -Prompt "What is the Mac Address of the computer you would like to make a reservation for? (e.g 64:5D:86:5D:25:E1)"
$MAC=$MAC -replace(':','')

$scope = Read-Host -Prompt "What scope would you like to make this reservation for? (e.g. 10.2.30.0)"

Get-DhcpServerv4Lease -ComputerName $dhcpserver -ScopeId $scope -ClientId $MAC | Add-DhcpServerv4Reservation -ComputerName $dhcpserver -Description $descript
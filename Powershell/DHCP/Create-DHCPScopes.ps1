#csv header format name;dhcpserver;startrange;endrange;subnetmask;scopeid;router

$path = C:\temp
$file = dhcpreservations.csv

$dhcpScopes = Import-Csv -Path "$path\$file"

Foreach ( $scope in $dhcpScopes) {
    Write-Output "Creating DHCP Scope $scope.name"
    Add-DhcpServerv4Scope -ComputerName $scope.dhcpserver -StartRange $scope.startrange -EndRange $scope.endrange -SubnetMask $scope.subnetmask -Name $scope.name -State Active
    Set-DhcpServerv4OptionValue -ComputerName $scope.dhcpserver -ScopeId $scope.scopeid -Router $scope.router
}
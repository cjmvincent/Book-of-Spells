#csv header format name;dhcpserver;startrange;endrange;subnetmask;scopeid;router

Import-Module -Name DHCPServer

$path = "C:\temp"
$file = "dhcpscopes.xlsx" 
$sheet = "Sheet1"

$dhcpScopes = Import-Excel -Path $path\$file -WorksheetName $Sheet

Foreach ( $scope in $dhcpScopes) {
    Write-Output "Creating DHCP Scope $($scope.name)"
    Add-DhcpServerv4Scope -ComputerName $scope.DHCPServer -StartRange $scope.StartRange -EndRange $scope.EndRange -SubnetMask $scope.SubnetMask -Name $scope.Name -State Active
    Set-DhcpServerv4OptionValue -ComputerName $scope.DHCPServer -ScopeId $scope.scopeID -Router $scope.Router
}
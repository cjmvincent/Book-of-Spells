Import-Module -Name ImportExcel
Import-Module -Name DHCPServer

$path = "C:\temp"
$file = "dhcp_stuff.xlsx" 
$sheet = "Scopes"

$dhcpScopes = Import-Excel -Path $path\$file -WorksheetName $Sheet

Foreach ( $scope in $dhcpScopes) {
    Write-Output "Creating DHCP Scope $($scope.Name)"
    Add-DhcpServerv4Scope -ComputerName $scope.DHCPServer -StartRange $scope.StartRange -EndRange $scope.EndRange -SubnetMask $scope.SubnetMask -Name $scope.Name -State Active
    Set-DhcpServerv4OptionValue -ComputerName $scope.DHCPServer -ScopeId $scope.ScopeID -Router $scope.Router
}
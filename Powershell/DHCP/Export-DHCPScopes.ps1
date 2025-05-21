Import-Module -Name DhcpServer

# Define DHCP server
$Server = "10.101.0.15"

# Get all scopes from the DHCP server
$Scopes = Get-DhcpServerv4Scope -ComputerName $Server

# Output file settings
$Path = "C:\temp"
$File = "dhcp_scopes.xlsx"
$Sheet = "Scopes"

# Loop through each scope and export details
foreach ($Scope in $Scopes) {
    $Entry = [PSCustomObject]@{
        ScopeID    = $Scope.ScopeId
        ScopeName  = $Scope.Name
        StartRange = $Scope.StartRange
        EndRange   = $Scope.EndRange
    }

    $Entry | Export-Excel -Path "$Path\$File" -WorksheetName $Sheet -Append
}

Write-Host "Finished exporting DHCP Scopes to $File."

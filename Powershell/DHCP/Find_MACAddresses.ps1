Import-Module ImportExcel
Import-Module DHCPServer

# Vars for the file to import and use
$Input_Path   = "\\bcboe-fs4\techshare\Charles\Camera_Migration"
$Input_File   = "Cameras.xlsx"
$Input_Sheet  = "Online_Status"

# Vars for the file to write to
$Output_Path  = "\\bcboe-fs4\techshare\Charles\Camera_Migration"
$Output_File  = "Cameras.xlsx"
$Output_Sheet = "DHCP_Leases_By_MAC"

# Load devices in sheet
$devices = Import-Excel -Path $Input_Path\$Input_File -WorksheetName $Input_Sheet

# Gather all of the leases from the following servers
$servers = @("bcboe-fs2","bcboe-fs3")
$allLeases = @()
foreach ($server in $servers) {
    $allLeases += Get-DhcpServerv4Scope -ComputerName $server | Get-DhcpServerv4Lease -ComputerName $server | Select-Object *, @{n='Server';e={$server}}
}

# Normalize the mac address in the list of leases gathered from DHCP servers
$leaseByMac = @{}
foreach ($lease in $allLeases) {
    $mac = ($lease.ClientID -replace '[^A-Fa-f0-9]', '').ToUpper()
    if ($mac -and -not $leaseByMac.ContainsKey($mac)) {
        $leaseByMac[$mac] = $lease
    }
}

$objectstoexport = @()

foreach ($device in $devices) {
    # Copy original properties of device
    $out = $device | Select-Object *

    # Normalize the device mac address
    $canon = $null
    if ($device.PSObject.Properties.Name -contains 'MACAddress' -and $device.MACAddress) {
        $canon = ($device.MACAddress -replace '[^A-Fa-f0-9]', '').ToUpper()
    }

    # Add DHCP properties to each device
    if (-not $canon) {
        # No ClientID in input
        $out | Add-Member -NotePropertyName DHCP_Status -NotePropertyValue 'No ClientID'
        $out | Add-Member -NotePropertyName DHCP_Server       -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_HostName     -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_IPAddress    -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_ScopeId      -NotePropertyValue $null
    }
    elseif ($leaseByMac.ContainsKey($canon)) {
        # These are devices that were found
        $lease = $leaseByMac[$canon]
        $out | Add-Member -NotePropertyName DHCP_Status -NotePropertyValue 'Found'
        $out | Add-Member -NotePropertyName DHCP_Server       -NotePropertyValue $lease.Server
        $out | Add-Member -NotePropertyName DHCP_HostName     -NotePropertyValue $lease.HostName
        $out | Add-Member -NotePropertyName DHCP_IPAddress    -NotePropertyValue $lease.IPAddress
        $out | Add-Member -NotePropertyName ScopeId      -NotePropertyValue $lease.ScopeId
    } else {
        # These are devices that were not found
        $out | Add-Member -NotePropertyName DHCP_Status -NotePropertyValue 'Not Found'
        $out | Add-Member -NotePropertyName DHCP_Server       -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_HostName     -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_IPAddress    -NotePropertyValue $null
        $out | Add-Member -NotePropertyName DHCP_ScopeId      -NotePropertyValue $null
    }

    $objectstoexport += $out

}

# Write it all at once
$objectstoexport | Export-Excel -Path $Output_Path\$Output_File -WorksheetName $Output_Sheet -ClearSheet -AutoSize
s
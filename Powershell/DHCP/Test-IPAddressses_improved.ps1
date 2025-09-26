Import-Module ImportExcel

$Source_Path = "C:\temp"
$Source_File = "printers.xlsx"
$Source_Worksheet = "Get-MACs"

$Dest_Path = "C:\temp"
$Dest_File = "printers.xlsx"
$Dest_Worksheet = "Status"

# Load all devices from the original sheet
$Devices = Import-Excel -Path "$Source_Path\$Source_File" -WorksheetName $Source_Worksheet

# Buffer for results
$Results = @()

# Test each device
foreach ($device in $Devices) {
    Write-Host "Testing $($device.PrinterName) - $($device.IPAddress)"
    
    $isOnline = Test-Connection -ComputerName $device.IPAddress -Count 1 -Quiet

    # Copy all original properties into a hashtable
    $props = @{}
    $device.PSObject.Properties | ForEach-Object {
        $props[$_.Name] = $_.Value
    }

    # Add new property
    $props["Status"] = if ($isOnline) { "Online" } else { "Offline" }

    # Convert back to object and add to results
    $Results += [PSCustomObject]$props
}

# Export results to new worksheet
$Results | Export-Excel -Path "$Dest_Path\$Dest_File" -WorksheetName $Dest_Worksheet -ClearSheet -AutoSize

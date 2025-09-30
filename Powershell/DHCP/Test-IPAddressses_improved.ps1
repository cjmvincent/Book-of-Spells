Import-Module ImportExcel

$Source_Path = "C:\temp"
$Source_File = "printers.xlsx"
$Source_Worksheet = "Printers"

$Dest_Path = "C:\temp"
$Dest_File = "printers.xlsx"
$Dest_Worksheet = "Status"

$Devices = Import-Excel -Path "$Source_Path\$Source_File" -WorksheetName $Source_Worksheet

$Results = @()

foreach ($device in $Devices) {

    #Write-Host "Testing $($device.PrinterName) - $($device.IPAddress)"
    
    $isOnline = Test-Connection -ComputerName $device.IPAddress -Count 1 -Quiet

    $props = @{}
    $device.PSObject.Properties | ForEach-Object {
        $props[$_.Name] = $_.Value
    }

    $props["NetworkStatus"] = if ($isOnline) { "Online" } else { "Offline" }

    $Results += [PSCustomObject]$props
}

$Results | Export-Excel -Path "$Dest_Path\$Dest_File" -WorksheetName $Dest_Worksheet -ClearSheet -AutoSize

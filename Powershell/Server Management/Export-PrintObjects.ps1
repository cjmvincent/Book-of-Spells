Import-Module -Name ImportExcel

# File to write results to
$Path = "C:\temp"
$File = "printers.xlsx"
$Sheet = "Printers"

$servers = @('PRINT-SRVR', 'PRINT-SRVR-RH', 'BCBOE-FS2', 'BCBOE-FS3')

foreach ($server in $servers) {
    $printers = Get-Printer -ComputerName $server
    $ports    = Get-PrinterPort -ComputerName $server

    foreach ($printer in $printers) {
        Write-Host "Saving $($printer.Name)"

        # Try to match port and extract IP
        $port = $ports | Where-Object { $_.Name -eq $printer.PortName }

        $entry = [pscustomobject]@{
            'Server'      = $server
            'PrinterName' = $printer.Name
            'Driver'      = $printer.DriverName
            'PortName'    = $printer.PortName
            'IPAddress'   = $port.PrinterHostAddress
        }

        $entry | Export-Excel -Path "$Path\$File" -WorksheetName $Sheet -Append -AutoSize
        Start-Sleep -Milliseconds 200
    }
}

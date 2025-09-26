#File to write results to
$Path = "C:\temp"
$File = "dhcp_stuff.xlsx"
$Sheet = "Leases"

$servers = @('PRINT-SRVR'
             'PRINT-SRVR-RH')

ForEach($server in $servers) {

    $printers = Get-Printer -ComputerName $server

        ForEach($printer in $printers) {

            $entry = [pscustomobject]@{
                'PrinterName' = $_.Name;
                'IPAddress' = $_.PortName;
                'Driver' = $_.DriverName}
            }

    $Entry | Export-Excel -Path $Path\$File -WorksheetName $Sheet -Append
    Start-Sleep -Milliseconds 500

}
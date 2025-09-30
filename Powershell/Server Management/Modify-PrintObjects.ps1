Import-Module ImportExcel

$Path = "C:\temp"
$File = "printers.xlsx"
$Sheet = "Get-MACs"

$printers = Import-Excel -Path $File\$Path -WorksheetName $Sheet

foreach ($printer in $printers) {

    $printerobject = Get-Printer -ComputerName $printer.Server -Name $printer.PrinterName
    $port    = Get-PrinterPort -ComputerName $printer.Server -Name $printerobject.PortName

    # Try updating the existing port
    Set-PrinterPort -ComputerName $printer.Server -Name $port.Name -PrinterHostAddress $printer.NewIPAddress -ErrorAction SilentlyContinue

    # If it didn’t take (some ports can’t be modified), create new and rebind
    if ($port.PrinterHostAddress -ne $printer.NewIPAddress) {
        $newPortName = "IP_$($printer.NewIPAddress)"
        if (-not (Get-PrinterPort -ComputerName $printer.Server -Name $newPortName -ErrorAction SilentlyContinue)) {
            Add-PrinterPort -ComputerName $printer.Server -Name $newPortName -PrinterHostAddress $printer.NewIPAddress
        }
        Set-Printer -ComputerName $printer.Server -Name $printer.PrinterName -PortName $newPortName
    }

    Write-Host "Updated $($printer.PrinterName) on $($printer.Server) to $($printer.NewIPAddress)"
}

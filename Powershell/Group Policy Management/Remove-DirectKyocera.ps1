$printer = get-printer |  Where {($_.DriverName -like "*kx*") -or ($_.DriverName -like "*kyocera*")} | Select -ExpandProperty Name
Remove-Printer -Name $printer -ComputerName $computer
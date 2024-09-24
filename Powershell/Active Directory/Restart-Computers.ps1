Import-Module ActiveDirectory

$computerList = Get-ADComputer -Filter * -SearchBase "OU=Workstations,DC=cjmvincent,DC=com" | Select-Object -ExpandProperty name
$downComputers = @()

ForEach ($computer in $computerList) {
    if (Test-Connection -ComputerName $computer -Count 1) {
        Write-Host "Rebooting $computer"
        #Restart-Computer -ComputerName $computer -Force
    } elseif (!(Test-Connection -ComputerName $computer -Count 1)) {
        $downComputers += $computer + "," + " "
    }
}

if ($downComputers -ge "1") {
    Write-Host "Computers $downComputers is/are unreachable. Please act accordingly."
}
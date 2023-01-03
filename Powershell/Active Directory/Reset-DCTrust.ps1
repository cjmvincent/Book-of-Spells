$creds = Get-Credential

Reset-ComputerMachinePassword -Server bcboe-dc1.bryan.k12.ga.us -Credential $creds

Write-Host "Establishing domain trust with DC 'bcboe-dc1'."

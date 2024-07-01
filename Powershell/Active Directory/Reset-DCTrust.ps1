$creds = Get-Credential

Reset-ComputerMachinePassword -Server dc.cjmvincent.com -Credential $creds

Write-Host "Establishing domain trust with DC 'bcboe-dc1'."

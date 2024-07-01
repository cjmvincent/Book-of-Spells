# Set variables to indicate value and key to set
$RegistryPath = 'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL'
$Name         = 'EventLogging'
$Value        = '7'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) {
  New-Item -Path $RegistryPath -Force | Out-Null
}  
# Now set the value
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force

# Set variables to indicate value and key to set
$RegistryPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics'
$Name         = '16 LDAP Interface Events'
$Value        = '4'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) {
  New-Item -Path $RegistryPath -Force | Out-Null
}  
# Now set the value
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force
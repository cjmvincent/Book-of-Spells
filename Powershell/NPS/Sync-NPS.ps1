$backup_path = "C:\temp\"
$dest_path = "\temp\"
$date = Get-Date -Format yyyy_MM_dd
$NPSDestServer = "South-DC1"

# Export NPS config on current server
Export-NpsConfiguration -Path $backup_path\NPSConfig_$date.xml

# Copy config to destination server
Copy-Item -Path $backup_path\NPSConfig_$date.xml -Destination \\$NPSDestServer\C$\$dest_path\NPSConfig_$date.xml

#LOL these invoke commands don't currenly work
# Export current config
#Invoke-Command -ComputerName $NPSDestServer -ScriptBlock {Export-NPSConfiguration -Path $backup_path\BackupNPSConfig_$date.xml}

# Import new config
#Invoke-Command -ComputerName $NPSDestServer -ScriptBlock {Import-NPSConfiguration -Path $backup_path\NPSConfig_$date.xml} 

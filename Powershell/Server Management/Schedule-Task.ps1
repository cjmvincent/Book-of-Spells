$action = New-ScheduledTaskAction -Execute "shutdown /r /f /t 0"
$trigger = New-ScheduledTaskTrigger -At 10pm -Once
$user = "SYSTEM"
$settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $action -TaskName Reboot -Settings $settings -Trigger $trigger -User $user



 

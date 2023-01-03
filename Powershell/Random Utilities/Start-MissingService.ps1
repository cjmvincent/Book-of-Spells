<#
Used to start a service known to have issues as a result of recent Windows Updates

Common Services:
Audio Endpoint = Audiosrv
Audio Enpoint Builder = AudioEndpointBuilder
Network Logon = NetLogon
WLAN AutoConfig = WLANsvc

#>

$comp = Read-Host -Prompt "What is the name of the computer?"
$service = Read-Host -Prompt "What service are you having issues with?
1. Do you not have audio, or is there a red 'X' over the speaker icon?
2. Do you not have Wifi, or is there a red 'X' over the internet icon?
3. Do you not have access to the shares drives?
"
Set-Service -Name $service -Status Running -StartupType Automatic
gpupdate /force

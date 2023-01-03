#Used typically after renaming the laptops, when they won't connect to the wifi immediately after renaming.
#Deletes personal certificate auths under personal folder. 

Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Issuer -match 'Bryan.K12.GA.US' } | Remove-Item
sleep -Seconds 3
gpupdate /force
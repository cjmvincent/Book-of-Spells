#Set variable for computer name.
Set-Variable -Name comp -Value (Read-Host -Prompt 'What is the computer name?')

#Set variable for username.
Set-Variable -Name user -Value (Read-Host -Prompt 'What is the user ID?')

#The following removes Chrome VPN Extenstions.

#Ultrasurf
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\mjnbclmflcpookeapghfhapeffmpodij

#DotVPN
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\kpiecbcckbofpmkkkdibbllpinceiihk

#Hoxx
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\nbcojefnccbanplpoffopkoepjmhgdgh

#BroweSec
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\omghfjlpggmjjaagoclmmobgdodcjboh

#SetupVPN
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\oofgbpoabipfcfjapgnbbjjaenockbdp

#Tunnello
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\hoapmlpnmpaehilehggglehfdlnoegck

#TunnelBear
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\omdakjcmkglenbhjadbccaookpfjihpa

#Betternet
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\gjknjjomckknofjidppipffbpoekiipm

#GOM
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\eelphgpfmjhndihoopgadghfonahifel

#SurfEasy
Remove-Item \\$comp\c$\Users\$user\AppData\Local\Google\Chrome\'User Data'\Default\Extensions\odiddbcijempnhhobijfbggjogofdlgl

$computerList = Get-Content -Path "C:\Computers\computers.txt"

ForEach ($computer in $computerList) {
    Copy-Item "\\wsus\Distrib\All\DRCInsight\COS1.cmd" "\\$computer\c$\DRC\"

    Start-Process "\\$computer\c$\DRC\COS1.cmd"
}
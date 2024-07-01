$computerList = Get-Content -Path "C:\Computers\computers.txt"

ForEach ($computer in $computerList) {
    Copy-Item "\\bcboe-wsus\Distrib\All\DRCInsight\SouthCOS1.cmd" "\\$computer\c$\DRC\"

    Start-Process "\\$computer\c$\DRC\SouthCOS1.cmd"
}
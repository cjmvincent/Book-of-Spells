Import-Module -Name DHCPServer

$addresses = @(
    "00-18-85-52-fc-df"
)

# $Input_Path = "C:\temp"
# $Input_File = "addresses"
# $Input_Sheet = "Sheet1"

# $addresses = Import-Excel -Path $Input_Path\$Input_File -WorksheetName $Input_Sheet

$Output_Path = "C:\temp"
$Output_File = "devices.xlsx"
$Output_Sheet = "Sheet1"

$Global:Data = @()

Function Find_MACs ($Server){

    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($address in $addresses){

            Write-Host "Looking for your addresses"

            If ($IP.ClientID -like "$address"){
                #Be sure to create your template excel file with the needed headers you see below
                $Device = [PSCustomObject]@{
                    HostName = $IP.HostName;
                    ClientID = $IP.ClientID;
                    IPAddress = $IP.IPAddress
                }
            #Append var to our spreadsheet for later use
            $Device | Export-Excel -Path $Output_Path\$Output_File -WorksheetName $Output_Sheet -Append
            #Pause momentarily so script doesn't run faster than the spreadsheet can be written to
            Start-Sleep -Milliseconds 500
            }
        }
    }
}

$servers = @(
    "bcboe-fs2"
    "bcboe-fs3"
)

foreach ($server in $servers) {
Find_MACs -Server $server
}

#$Global:Data |Format-Table -AutoSize
#$Global:Data | Out-File -FilePath C:\temp\trash.csv
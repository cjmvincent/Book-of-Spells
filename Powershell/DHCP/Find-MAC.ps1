Import-Module -Name DHCPServer

$Input_Path = "C:\temp"
$Input_File = "dhcp_stuff.xlsx"
$Input_Sheet = "Hosts"

$addresses = Import-Excel -Path $Input_Path\$Input_File -WorksheetName $Input_Sheet

$Output_Path = "C:\temp"
$Output_File = "dhcp_stuff.xlsx"
$Output_Sheet = "Found"

$Global:Data = @()

Function Find_MACs ($Server){

    Write-Host "Looking for your addresses..."

    $All_IPs = Get-DhcpServerv4Scope -ComputerName $Server | Get-DhcpServerv4Lease -ComputerName $Server
    ForEach($IP in $All_IPs){
        ForEach ($address in $addresses){
            If ($IP.ClientID -like $address.ClientID){
                #Be sure to create your template excel file with the needed headers you see below
                Write-Host "Found $address.ClientID..."
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
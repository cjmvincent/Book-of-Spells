Import-Module -Name DHCPServer

$server = "bcboe-fs2"
$option = "ntp server"
$optionid = "042"
$value = "10.8.0.120"

Set-DhcpServerv4OptionValue -ComputerName $server -OptionId $optionid -Value $value
$server = "bcboe-fs2"
$option = "ntp server"
$optionid = "042"

Set-DhcpServerv4OptionValue -ComputerName $server -OptionId $optionid -Value 10.8.0.120,10.8.0.121

#MES Network#
$MDF1 = New-Object PSObject
$MDF1 | Add-Member -MemberType NoteProperty -Name Name -Value MDF1
$MDF1 | Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.2

$IDF1 = New-Object PSObject
$IDF1 | Add-Member -MemberType NoteProperty -Name Name -Value IDF1
$IDF1 | Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.11

$IDF2 = New-Object PSObject
$IDF2 | Add-Member -MemberType NoteProperty -Name Name -Value IDF2
$IDF2| Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.21

$IDF3 = New-Object PSObject
$IDF3 | Add-Member -MemberType NoteProperty -Name Name -Value IDF3
$IDF3 | Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.31

$IDF4 = New-Object PSObject
$IDF4 | Add-Member -MemberType NoteProperty -Name Name -Value IDF4
$IDF4 | Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.41

$IDF5 = New-Object PSObject
$IDF5 | Add-Member -MemberType NoteProperty -Name Name -Value IDF5
$IDF5 | Add-Member -MemberType NoteProperty -Name IP -Value 10.9.2.51


$Network = @($MDF1, $IDF1, $IDF2, $IDF3, $IDF4, $IDF5)
$downClosets = @()


ForEach ($closet in $Network) {
    if (Test-Connection $closet.IP) {
    Write-Host $closet.Name "is reachable."
    } elseif (!(Test-Connection $closet.IP)) {
    $downClosets += $closet.Name + "," + " "
    }
}

if ($downClosets -ge "1") {
    Write-Host "Closets $downClosets is/are unreachable. Please act accordingly."
}
$trash = @(
    "Microsoft.XboxApp"
)

foreach ($package in $trash) {
    Write-Host "Attempting to remove package: $package"
    try {
        Get-AppxPackage -Name "*$package*" -AllUsers | Remove-AppxPackage -ErrorAction Stop
        Write-Host "Successfully removed package: $package"
    }
    catch {
        Write-Warning "Failed to remove package: $package. Error: $($_.Exception.Message)"
    }
}
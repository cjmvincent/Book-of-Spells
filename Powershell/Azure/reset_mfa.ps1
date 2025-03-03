# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "UserAuthenticationMethod.ReadWrite.All", "User.ReadWrite.All"

# Function to revoke a user's MFA configuration
function Revoke-EntraUserMFAConfiguration {
    param (
        [Parameter(Mandatory = $true)]
        [string]$UserPrincipalName
    )

    try {
        # Get the user object
        $user = Get-MgUser -Filter "userPrincipalName eq '$UserPrincipalName'"
        if (-not $user) {
            Write-Host "User not found: $UserPrincipalName" -ForegroundColor Red
            return
        }

        # List all authentication methods for the user
        $authMethods = Get-MgUserAuthenticationMethod -UserId $user.Id

        # Iterate through each authentication method and remove them
        foreach ($method in $authMethods) {
            Write-Host "Removing authentication method: $($method.Id)" -ForegroundColor Yellow
            Remove-MgUserAuthenticationMethod -UserId $user.Id -AuthenticationMethodId $method.Id
        }

        # Revoke user sessions (refresh tokens)
        Write-Host "Revoking user sessions..." -ForegroundColor Yellow
        Revoke-MgUserSignInSession -UserId $user.Id

        Write-Host "MFA configuration and sessions revoked successfully for $UserPrincipalName" -ForegroundColor Green
    } catch {
        Write-Host "Error revoking MFA configuration: $_" -ForegroundColor Red
    }
}

# Example usage
# Replace 'user@example.com' with the UPN of the user you want to revoke MFA for
Revoke-EntraUserMFAConfiguration -UserPrincipalName 'user@example.com'

# Disconnect from Microsoft Graph
Disconnect-MgGraph
s
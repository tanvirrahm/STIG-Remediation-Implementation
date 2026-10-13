
<#
.SYNOPSIS
    Disables Basic authentication for the Windows Remote
    Management (WinRM) client on Windows 11.

.NOTES
    Author          : Golam Tanvir Rahman
    LinkedIn        : linkedin.com/in/tanvir-cyber/
    GitHub          : github.com/tanvirrahm
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000330
    Documentation   : https://stigaview.com/products/win11/v2r9/WN11-CC-000330/

.TESTED ON
    Date(s) Tested  : 2026-10-12
    Tested By       : Golam Tanvir Rahman
    Systems Tested  : Windows 11 Azure VM
    PowerShell Ver. : 5.1.26100.9444

.USAGE
    Run PowerShell as Administrator.
    PS C:\> .\WN11-CC-000330.ps1
#>

# Set the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"

# Create the registry path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Disable WinRM Client Basic authentication
New-ItemProperty -Path $registryPath -Name "AllowBasic" -Value 0 -PropertyType DWord -Force | Out-Null

# Confirm the value was set
Get-ItemProperty -Path $registryPath |
    Select-Object AllowBasic

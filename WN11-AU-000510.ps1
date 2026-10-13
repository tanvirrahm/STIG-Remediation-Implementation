
<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the
    Windows System event log is at least 32768 KB (32 MB),
    in compliance with STIG WN11-AU-000510.

.NOTES
    Author          : Golam Tanvir Rahman
    LinkedIn        : linkedin.com/in/tanvir-cyber/
    GitHub          : github.com/tanvirrahm
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000510
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000510/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script in PowerShell with Administrator privileges.

    The script configures the registry value "MaxSize" to
    32768 (DWORD) under:

    HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System

    This ensures the Windows System event log has a
    maximum size of at least 32 MB.

    Example syntax:
    PS C:\> .\WN11-AU-000510.ps1

    Verify compliance by rescanning the system using
    Tenable Windows Compliance Checks.
#>
# Set the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"

# Create the registry path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the maximum log size to 32768 KB
New-ItemProperty -Path $registryPath -Name "MaxSize" -Value 32768 -PropertyType DWord -Force | Out-Null

# Confirm the value was set
Get-ItemProperty -Path $registryPath |
    Select-Object MaxSize


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
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$Name = "MaxSize"
$RequiredValue = 32768

# Check current registry value
$Before = Get-ItemProperty -Path $Path `
    -Name $Name -ErrorAction SilentlyContinue

Write-Host "Current value: $($Before.$Name)"

# Create registry path if missing
New-Item -Path $Path -Force -ErrorAction Stop |
    Out-Null

# Apply STIG remediation
New-ItemProperty -Path $Path `
    -Name $Name `
    -Value $RequiredValue `
    -PropertyType DWORD `
    -Force -ErrorAction Stop | Out-Null

# Verify registry configuration
$After = (Get-ItemProperty -Path $Path `
    -Name $Name -ErrorAction Stop).$Name

if ($After -ge $RequiredValue) {
    Write-Host "PASS: WN11-AU-000510 remediated." `
        -ForegroundColor Green
} else {
    Write-Host "FAIL: Remediation unsuccessful." `
        -ForegroundColor Red
    exit 1
}

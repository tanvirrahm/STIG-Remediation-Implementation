
<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Golam Tanvir Rahman
    LinkedIn        : linkedin.com/in/tanvir-cyber/
    GitHub          : github.com/tanvirrahm
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$Name = "MaxSize"
$RequiredValue = 32768

# Check existing value
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

# Verify registry value
$After = (Get-ItemProperty -Path $Path `
    -Name $Name -ErrorAction Stop).$Name

if ($After -ge $RequiredValue) {
    Write-Host "PASS: WN11-AU-000500 remediated." `
        -ForegroundColor Green
} else {
    Write-Host "FAIL: Remediation unsuccessful." `
        -ForegroundColor Red
    exit 1
}

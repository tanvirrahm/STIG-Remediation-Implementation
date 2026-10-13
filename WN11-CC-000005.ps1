
<#
.SYNOPSIS
    This PowerShell script disables camera access from the
    Windows 11 lock screen by configuring the
    NoLockScreenCamera registry value to 1.

    This remediates STIG WN11-CC-000005.
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
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000005/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script in PowerShell with Administrator privileges.

    The script creates or modifies the following registry value:

    Registry Path:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization

    Value Name : NoLockScreenCamera
    Value Type : REG_DWORD
    Value Data : 1

    This prevents camera access from the Windows 11 lock screen.

    Example syntax:
    PS C:\> .\WN11-CC-000005.ps1

    Verification:
    Confirm that NoLockScreenCamera is set to 1.
    Run a Tenable Windows 11 STIG compliance scan and verify
    that WN11-CC-000005 reports PASSED.

    The remediation was verified as PASSED in Tenable.
#>

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$Name = "NoLockScreenCamera"
$RequiredValue = 1

# Display current setting
$Before = Get-ItemProperty -Path $Path `
    -Name $Name -ErrorAction SilentlyContinue

Write-Host "Before: $($Before.$Name)"

# Create registry path if needed
New-Item -Path $Path -Force -ErrorAction Stop |
    Out-Null

# Apply STIG remediation
New-ItemProperty -Path $Path `
    -Name $Name `
    -Value $RequiredValue `
    -PropertyType DWord `
    -Force -ErrorAction Stop | Out-Null

# Verify the new setting
$After = (Get-ItemProperty -Path $Path `
    -Name $Name -ErrorAction Stop).$Name

if ($After -eq $RequiredValue) {
    Write-Host "PASS: WN11-CC-000005 registry setting applied." `
        -ForegroundColor Green
} else {
    Write-Host "FAIL: Remediation unsuccessful." `
        -ForegroundColor Red
    exit 1
}

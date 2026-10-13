<#
.SYNOPSIS
    This PowerShell script disables lock screen slide shows
    on Windows 11 by configuring the NoLockScreenSlideshow
    registry value to 1.

    This remediates STIG WN11-CC-000010.

.NOTES
    Author          : Golam Tanvir Rahman
    LinkedIn        : linkedin.com/in/tanvir-cyber/
    GitHub          : github.com/tanvirrahm
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000010
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000010/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script in PowerShell with Administrator privileges.

    The script creates or modifies the following registry entry:

    Registry Path:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization

    Value Name : NoLockScreenSlideshow
    Value Type : REG_DWORD
    Value Data : 1

    This prevents Windows 11 from displaying slide shows
    on the lock screen.

    Example syntax:
    PS C:\> .\WN11-CC-000010.ps1

    Verification:
    Confirm that NoLockScreenSlideshow is set to 1.
    Run a Tenable Windows 11 STIG compliance scan and verify
    that WN11-CC-000010 reports PASSED.

    Tenable compliance verification: PASSED.
#>


$ErrorActionPreference = "Stop"

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$Name = "NoLockScreenSlideshow"
$RequiredValue = 1

try {
    # Check current configuration
    $Before = Get-ItemProperty -Path $Path `
        -Name $Name -ErrorAction SilentlyContinue

    Write-Host "Before: $($Before.$Name)"

    # Create registry path if missing
    New-Item -Path $Path -Force | Out-Null

    # Apply STIG remediation
    New-ItemProperty -Path $Path `
        -Name $Name `
        -Value $RequiredValue `
        -PropertyType DWord `
        -Force | Out-Null

    # Verify registry value
    $After = Get-ItemPropertyValue -Path $Path -Name $Name

    if ($After -eq $RequiredValue) {
        Write-Host "PASS: WN11-CC-000010 registry setting applied." `
            -ForegroundColor Green
    }
    else {
        Write-Host "FAIL: Incorrect registry value." `
            -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" `
        -ForegroundColor Red
    exit 1
}

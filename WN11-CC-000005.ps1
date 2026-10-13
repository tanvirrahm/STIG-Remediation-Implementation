
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
    STIG-ID         : WN11-CC-000005
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

# Set the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the registry path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Disable lock screen camera
New-ItemProperty -Path $registryPath -Name "NoLockScreenCamera" -Value 1 -PropertyType DWord -Force | Out-Null

# Confirm the value was set
Get-ItemProperty -Path $registryPath |
    Select-Object NoLockScreenCamera
}

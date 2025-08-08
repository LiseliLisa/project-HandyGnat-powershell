#
# Temporarily Enable Unrestricted Execution Policy:
# Set-ExecutionPolicy Unrestricted -Scope Process -Force
#

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)][Switch]$Default,
    [Parameter(Mandatory=$false)][Switch]$Sysprep
)
try {
    if ($Default){
        & ([scriptblock]::Create((Invoke-RestMethod "https://debloat.raphi.re/"))) -RemoveApps -RemoveGamingApps
    }
    if ($Sysprep){
        & ([scriptblock]::Create((Invoke-RestMethod "https://debloat.raphi.re/"))) -Sysprep -RemoveApps -RemoveGamingApps
    }
    exit 0
}
catch {
    exit 1
}
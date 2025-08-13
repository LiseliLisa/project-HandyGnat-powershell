#
# Temporarily Enable Unrestricted Execution Policy:
# Set-ExecutionPolicy Unrestricted -Scope Process -Force
#

#Requires -RunAsAdministrator
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
}
catch {
    Write-Host "Somebody cut the wrong wire!" -ForegroundColor Red
    Write-Output ""
    Write-Output "Press any key to exit..."
    $null = [System.Console]::ReadKey()
    exit 1
}
finally{
    Write-Host "Debloat was successful!" -ForegroundColor Green
    Write-Output ""
    Write-Output "Press any key to exit..."
    $null = [System.Console]::ReadKey()
    exit 0
}
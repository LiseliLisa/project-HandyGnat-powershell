#
# Temporarily Enable Unrestricted Execution Policy:
# Set-ExecutionPolicy Unrestricted -Scope Process -Force
#

#Requires -RunAsAdministrator
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)][Switch]$TaskbarLeft,
    [Parameter(Mandatory=$false)][Switch]$TaskviewOff,
    [Parameter(Mandatory=$false)][Switch]$WidgetsOff,
    [Parameter(Mandatory=$false)][Switch]$CopilotOff,
    [Parameter(Mandatory=$false)][Switch]$DisableFaststart,
    [Parameter(Mandatory=$false)][Switch]$HideSearchbar,
    [Parameter(Mandatory=$false)][Switch]$ShowFileExtention,
    [Parameter(Mandatory=$false)][Switch]$Darkmode
)
try {
    if ($TaskbarLeft){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name TaskbarAl -Value 0
    }
    if ($TaskviewOff){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Value 0
    }
    if ($WidgetsOff){
        Set-ItemProperty "HKLM:\Software\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name value -Value 0
        Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Dsh" -Name AllowNewsAndInterests -Value 0
    }
    if ($CopilotOff){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowCopilotButton -Value 0
        Set-ItemProperty "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name TurnOffWindowsCopilot -Value 1
        Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name TurnOffWindowsCopilot -Value 1
    }
    if ($DisableFaststart){
        Set-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0
    }
    if ($HideSearchbar){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name SearchboxTaskbarMode -Value 0
    }
    if ($ShowFileExtention){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0
    }
    if ($Darkmode){
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0
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
    if ([System.Environment]::Is64BitProcess -eq [System.Environment]::Is64BitOperatingSystem){
        Stop-Process -ProcessName:Explorer -Force
        Write-Host "All settings have been applied!" -ForegroundColor Green
        Write-Output ""
        Write-Output "Press any key to exit..."
        $null = [System.Console]::ReadKey()
        exit 0
    }
    else{
        Write-Host "A reboot is required for all changes to take effect!" -ForegroundColor Yellow
        Write-Output ""
        Write-Output "Press any key to exit..."
        $null = [System.Console]::ReadKey()
        exit 0
    }
}
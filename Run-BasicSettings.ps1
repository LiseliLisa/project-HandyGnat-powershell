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
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced").Property -contains "TaskbarAl") {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name TaskbarAl -Value 0
            Write-Host "Taskbar aligned left" -ForegroundColor Green
        }
        else{
            Write-Host "Taskbar couldn't be aligned" -ForegroundColor Red
        }
    }
    if ($TaskviewOff){
        if ((Get-Item"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced").Property -contains "ShowTaskViewButton"){
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Value 0
            Write-Host "Taskview turned off" -ForegroundColor Green
        }
        else{
            Write-Host "Taskview couldn't be disabled" -ForegroundColor Red
        }
    }
    if ($WidgetsOff){
        if ((Get-Item "HKLM:\Software\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests").Property -contains "value"){
            Set-ItemProperty "HKLM:\Software\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name value -Value 0
            Write-Host "Widgets disabled" -ForegroundColor Green
        }
        else{
            Write-Host "Widgets couldn't be disabled" -ForegroundColor Red
        }
        if ((Get-Item "HKLM:\Software\Policies\Microsoft\Dsh").Property -contains "value"){
            Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Dsh" -Name AllowNewsAndInterests -Value 0
            Write-Host "Widgets disabled" -ForegroundColor Green
        }
        else{
            Write-Host "Policy not updated" -ForegroundColor Red
        }
    }
    if ($CopilotOff){
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced").Property -contains "ShowCopilotButton"){
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowCopilotButton -Value 0
            Write-Host "Co-Pilot Button disabled" -ForegroundColor Green
        }
        else{
            Write-Host "Co-Pilot Button couldn't be disabled" -ForegroundColor Red
        }
        if ((Get-Item "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot").Property -contains "TurnOffWindowsCopilot") {
            Set-ItemProperty "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name TurnOffWindowsCopilot -Value 1
            Write-Host "Co-Pilot turned off for current user" -ForegroundColor Green
        }
        else{
            Write-Host "Co-Pilot couldn't be turned off for current user" -ForegroundColor Red
        }
        if ((Get-Item "HKLM:\Software\Policies\Microsoft\Windows\WindowsCopilot").Property -contains "TurnOffWindowsCopilot") {
            Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name TurnOffWindowsCopilot -Value 1
            Write-Host "Co-Pilot turned off for local machine" -ForegroundColor Green
        }
        else{
            Write-Host "Co-Pilot couldn't be turned off for local machine" -ForegroundColor Red
        }
    }
    if ($DisableFaststart){
        if ((Get-Item "HKLM:\System\CurrentControlSet\Control\Session Manager\Power").Property -contains "HiberbootEnabled") {
            Set-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0
            Write-Host "Faststart disabled" -ForegroundColor Green
        }
        else{
            Write-Host "Faststart couldn't be disabled" -ForegroundColor Red
        }
    }
    if ($HideSearchbar){
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search").Property -contains "SearchboxTaskbarMode") {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name SearchboxTaskbarMode -Value 0
            Write-Host "Searchbar hidden" -ForegroundColor Green
        }
        else{
            Write-Host "Searchbar couldn't be hidden" -ForegroundColor Red
        }
    }
    if ($ShowFileExtention){
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced").Property -contains "HideFileExt") {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0
            Write-Host "File extentions enabled" -ForegroundColor Green
        }
        else{
            Write-Host "File extentions couldn't be enabled" -ForegroundColor Red
        }
    }
    if ($Darkmode){
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize").Property -contains "AppsUseLightTheme") {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0
            Write-Host "Darkmode enabled for apps" -ForegroundColor Green
        }
        else{
            Write-Host "Darkmode couldn't be enabled for apps" -ForegroundColor Red
        }
        if ((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize").Property -contains "SystemUsesLightTheme") {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0
            Write-Host "Darkmode enabled for system" -ForegroundColor Green
        }
        else{
            Write-Host "Darkmode couldn't be enabled for system" -ForegroundColor Red
        }
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
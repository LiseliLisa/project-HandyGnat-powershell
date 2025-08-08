#
# Temporarily Enable Unrestricted Execution Policy:
# Set-ExecutionPolicy Unrestricted -Scope Process -Force
#

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)][Switch]$TaskbarLeft,
    [Parameter(Mandatory=$false)][Switch]$TaskviewOff,
    [Parameter(Mandatory=$false)][Switch]$WidgetsOff,
    [Parameter(Mandatory=$false)][Switch]$CopilotOff
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
        Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name TurnOffWindowsCopilot -Value 1
    }
}
catch {
    exit 1
}
#
# Temporarily Enable Unrestricted Execution Policy:
# Set-ExecutionPolicy Unrestricted -Scope Process -Force
#

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)][Switch]$Chrome,
    [Parameter(Mandatory=$false)][Switch]$Firefox,
    [Parameter(Mandatory=$false)][Switch]$AdobeReader,
    [Parameter(Mandatory=$false)][Switch]$Flameshot,
    [Parameter(Mandatory=$false)][Switch]$MSTeams
)
try {
    if ($Chrome){
        winget install -e -h --id Google.Chrome
    }
    if ($Firefox) {
        winget install -e -h --id Mozilla.Firefox
    }
    if ($AdobeReader) {
        winget install -e -h --id Adobe.Acrobat.Reader.64-bit
    }
    if ($Flameshot) {
        winget install -e -h --id Flameshot.Flameshot
    }
    if ($MSTeams) {
        winget install -e -h --id Microsoft.Teams
    }
}
catch {
    exit 1
}
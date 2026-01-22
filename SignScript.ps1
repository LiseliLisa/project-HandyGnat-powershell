[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)][String]$Script,
    [Parameter(Mandatory = $true)][String]$Certificate
)
try {
    Set-AuthenticodeSignature -FilePath $Path -Certificate $Certificate -TimeStampServer http://timestamp.digicert.com

} catch {
    Write-Output "Isch nid gange!"
}
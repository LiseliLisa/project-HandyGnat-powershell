[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)][String]$Path,
    [Parameter(Mandatory = $true)][String]$Certificate
)
try {
    $codeCertificate = Get-ChildItem Cert:\LocalMachine\Root\ | Where-Object {$_.Subject -eq "CN=$Certificate"}
    Set-AuthenticodeSignature -FilePath $Path -Certificate $codeCertificate -TimeStampServer http://timestamp.digicert.com
} catch {
    Write-Output "Isch nid gange!"
}
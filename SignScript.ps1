[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [String]$Path
)
try {
    $codeCertificate = Get-ChildItem Cert:\Current User\my\ | Where-Object {$_.Subject -eq "CN=Sozialinfo"}
    Set-AuthenticodeSignature -FilePath $Path -Certificate $codeCertificate -TimeStampServer http://timestamp.digicert.com
} catch {
    Write-Output "Isch nid gange!"
}
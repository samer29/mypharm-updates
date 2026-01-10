# Script PowerShell pour calculer le checksum SHA-256 d'un fichier ZIP
# Usage: .\calculate-checksum.ps1 "MyPharm-7.2.5.zip"

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

if (-not (Test-Path $FilePath)) {
    Write-Host "❌ Fichier non trouvé: $FilePath" -ForegroundColor Red
    exit 1
}

Write-Host "📦 Calcul du checksum SHA-256 pour: $FilePath" -ForegroundColor Cyan
Write-Host ""

$hash = Get-FileHash -Path $FilePath -Algorithm SHA256

Write-Host "✅ Checksum SHA-256 (majuscules):" -ForegroundColor Green
Write-Host $hash.Hash -ForegroundColor Yellow
Write-Host ""
Write-Host "📊 Taille du fichier: $([math]::Round((Get-Item $FilePath).Length / 1MB, 2)) MB ($((Get-Item $FilePath).Length) bytes)" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Copiez cette valeur dans latest.json :" -ForegroundColor Cyan
Write-Host $hash.Hash -ForegroundColor Yellow


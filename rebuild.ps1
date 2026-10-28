# =============================================================================
# rebuild.ps1 - Re-apply Kun's dotfiles and agent configurations on Windows
# =============================================================================
# Run this every time you modify files in your dotfiles repository.
# =============================================================================

[CmdletBinding()]
param(
    [switch]$SyncKun,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$DotfilesDir = $PSScriptRoot
$HomeDir = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)

Write-Host "==> Re-applying Kun's dotfiles config..." -ForegroundColor Magenta

# Run bootstrap with package install skipped
$bootstrap = Join-Path $DotfilesDir "bootstrap.ps1"
if (Test-Path $bootstrap) {
    & $bootstrap -SkipPackages -SkipKunTools:(-not $SyncKun) -Force:$Force
} else {
    Write-Error "bootstrap.ps1 not found in $DotfilesDir"
}

Write-Host "==> Finished applying dotfiles." -ForegroundColor Green

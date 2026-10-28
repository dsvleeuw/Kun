# =============================================================================
# lavish.ps1 - Lavish Editor Launcher for Windows
# =============================================================================
# Opens an HTML artifact in your local browser for interactive review,
# element pinpointing, text annotations, and Mermaid whiteboard editing.
#
# Usage:
#   .\lavish.ps1 path\to\artifact.html
#   lavish path\to\artifact.html
# =============================================================================

[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$ArtifactPath,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$LavishArgs
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error "Node.js is not found on PATH. Please install Node.js (e.g. winget install OpenJS.NodeJS.LTS)."
    exit 1
}

if (-not $ArtifactPath) {
    # If no file specified, search for 00_*.html in current directory
    $defaultArtifacts = Get-ChildItem -Path (Get-Location) -Filter "*.html" | Sort-Object Name
    if ($defaultArtifacts.Count -gt 0) {
        $ArtifactPath = $defaultArtifacts[0].FullName
        Write-Host "No artifact specified. Opening first found: $($defaultArtifacts[0].Name)" -ForegroundColor Cyan
    } else {
        Write-Host "Lavish Editor for Windows" -ForegroundColor Magenta
        Write-Host "Usage: lavish <path-to-html-artifact>" -ForegroundColor White
        Write-Host "Example: lavish .\00_OVERZICHT_ARCHITECTUUR.html" -ForegroundColor Gray
        exit 0
    }
}

$resolvedPath = Resolve-Path $ArtifactPath -ErrorAction SilentlyContinue
if (-not $resolvedPath) {
    Write-Error "Artifact not found: $ArtifactPath"
    exit 1
}

Write-Host "Opening in Lavish Editor: $resolvedPath" -ForegroundColor Green

# Prefer globally or locally installed lavish-axi, fallback to npx
if (Get-Command lavish-axi -ErrorAction SilentlyContinue) {
    lavish-axi "$resolvedPath" @LavishArgs
} else {
    npx -y lavish-axi "$resolvedPath" @LavishArgs
}

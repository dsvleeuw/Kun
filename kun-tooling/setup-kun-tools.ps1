# =============================================================================
# setup-kun-tools.ps1 - Install Kun Chen's Principal Engineer Agent Tooling on Windows
# =============================================================================

[CmdletBinding()]
param(
    [switch]$SkipPull,
    [switch]$SkipNpmGlobals
)

$ErrorActionPreference = "Stop"

Write-Host "============================================================" -ForegroundColor Magenta
Write-Host "  Kun Chen Agentic Engineering Tools Setup for Windows" -ForegroundColor Magenta
Write-Host "============================================================" -ForegroundColor Magenta

# 1. Verify Node.js and npm
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error "Node.js is not found on PATH. Please install Node.js (e.g. via winget install OpenJS.NodeJS.LTS)."
    exit 1
}

Write-Host "[1/4] Installing /kun skill globally..." -ForegroundColor Cyan
try {
    # Install /kun skill via Agent Skills CLI
    npx -y skills add kunchenguid/kun -g
    Write-Host "  ✓ /kun skill installed successfully" -ForegroundColor Green
} catch {
    Write-Warning "  ! Failed to register /kun skill via skills CLI. You can run manually: npx skills add kunchenguid/kun -g"
}

Write-Host "[2/4] Installing Kun's AXI (Agent eXperience Interface) skills..." -ForegroundColor Cyan
# gh-axi (Token-efficient GitHub CLI for agents)
try {
    npx -y skills add kunchenguid/gh-axi --skill gh-axi -g
    Write-Host "  ✓ gh-axi skill installed" -ForegroundColor Green
} catch {
    Write-Warning "  ! Failed to register gh-axi skill. Run manually: npx skills add kunchenguid/gh-axi --skill gh-axi -g"
}

# lavish-axi (Interactive HTML artifact review)
try {
    npx -y skills add kunchenguid/lavish-axi --skill lavish
    Write-Host "  ✓ lavish-axi skill installed" -ForegroundColor Green
} catch {
    Write-Warning "  ! Failed to register lavish-axi skill. Run manually: npx skills add kunchenguid/lavish-axi --skill lavish"
}

if (-not $SkipNpmGlobals) {
    Write-Host "[3/4] Installing CLI utilities (quota-axi, gnhf)..." -ForegroundColor Cyan
    # quota-axi (LLM quota viewer)
    try {
        npm install -g quota-axi --quiet
        Write-Host "  ✓ quota-axi CLI installed" -ForegroundColor Green
    } catch {
        Write-Warning "  ! Could not install quota-axi globally. Run: npm install -g quota-axi"
    }

    # gnhf (Good Night Have Fun - overnight autonomous agent loop)
    try {
        npm install -g gnhf --quiet
        Write-Host "  ✓ gnhf CLI installed" -ForegroundColor Green
    } catch {
        Write-Warning "  ! Could not install gnhf globally. Run: npm install -g gnhf"
    }
} else {
    Write-Host "[3/4] Skipped npm global CLIs (-SkipNpmGlobals specified)." -ForegroundColor Yellow
}

if (-not $SkipPull) {
    Write-Host "[4/4] Syncing Kun's living docs (ENTRY, TOOLS, OPINIONS, VOICE)..." -ForegroundColor Cyan
    $pullScript = Join-Path $PSScriptRoot "scripts\pull-kun.mjs"
    if (Test-Path $pullScript) {
        node $pullScript
        Write-Host "  ✓ Living docs cached at ~/.cache/kun" -ForegroundColor Green
    }
}

Write-Host "`nAll Kun tools and skills are ready on Windows!" -ForegroundColor Green
Write-Host "Usage in your AI coding agent (Claude Code, Codex, Grok):" -ForegroundColor White
Write-Host "  /kun how should I improve my AGENTS.md?" -ForegroundColor Gray
Write-Host "  /kun how would you design this architecture?" -ForegroundColor Gray
Write-Host "  quota-axi               # View active LLM quotas" -ForegroundColor Gray

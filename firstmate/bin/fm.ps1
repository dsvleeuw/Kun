# =============================================================================
# fm.ps1 - Firstmate Agent Distro Launcher for Windows
# =============================================================================
# Manages your autonomous agent fleet on Windows.
# Talk to one agent (First Mate) and ship with a crew in isolated git worktrees.
#
# Usage:
#   .\fm.ps1 [status | start | herdr | bearings | help]
# =============================================================================

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("status", "start", "herdr", "bearings", "afk", "quiet", "help")]
    [string]$Command = "status",

    [Parameter(Position = 1)]
    [string]$Harness = "claude"
)

$ErrorActionPreference = "Stop"
$FirstmateHome = Split-Path -Parent $PSScriptRoot

function Write-FmBanner {
    Write-Host ""
    Write-Host "  ⚓ FIRSTMATE FOR WINDOWS" -ForegroundColor Cyan
    Write-Host "  Talk to one agent. Ship with a crew." -ForegroundColor DarkCyan
    Write-Host "  Home: $FirstmateHome" -ForegroundColor DarkGray
    Write-Host ""
}

switch ($Command) {
    "status" {
        Write-FmBanner
        Write-Host "Fleet Status:" -ForegroundColor White
        
        # Check backend tools
        $herdrInstalled = [bool](Get-Command herdr -ErrorAction SilentlyContinue)
        $tmuxInstalled = [bool](Get-Command tmux -ErrorAction SilentlyContinue)
        $wslInstalled = [bool](Get-Command wsl -ErrorAction SilentlyContinue)
        $ghInstalled = [bool](Get-Command gh -ErrorAction SilentlyContinue)
        
        Write-Host "  GitHub CLI (gh): " -NoNewline
        if ($ghInstalled) { Write-Host "✓ Ready" -ForegroundColor Green } else { Write-Host "✗ Missing (run: winget install Git.Git)" -ForegroundColor Red }
        
        Write-Host "  Session Backend (Herdr): " -NoNewline
        if ($herdrInstalled) { Write-Host "✓ Ready (Native Windows)" -ForegroundColor Green } else { Write-Host "! Not installed (run: winget install herdr or cargo install herdr)" -ForegroundColor Yellow }

        Write-Host "  Session Backend (WSL tmux): " -NoNewline
        if ($wslInstalled) { Write-Host "✓ Ready (via WSL)" -ForegroundColor Green } else { Write-Host "! WSL not detected" -ForegroundColor DarkGray }

        # Check harnesses
        Write-Host "`nAvailable Agent Harnesses:" -ForegroundColor White
        $claude = [bool](Get-Command claude -ErrorAction SilentlyContinue)
        $pi = [bool](Get-Command pi -ErrorAction SilentlyContinue)
        $codex = [bool](Get-Command codex -ErrorAction SilentlyContinue)
        
        Write-Host "  Claude Code (claude): $(if ($claude) { '✓ Ready' } else { 'Not installed' })" -ForegroundColor $(if ($claude) { 'Green' } else { 'DarkGray' })
        Write-Host "  Pi Agent (pi):        $(if ($pi) { '✓ Ready' } else { 'Not installed' })" -ForegroundColor $(if ($pi) { 'Green' } else { 'DarkGray' })
        Write-Host "  Codex CLI (codex):    $(if ($codex) { '✓ Ready' } else { 'Not installed' })" -ForegroundColor $(if ($codex) { 'Green' } else { 'DarkGray' })

        Write-Host "`nCommands:" -ForegroundColor White
        Write-Host "  fm start [claude|pi|codex] - Launch First Mate session" -ForegroundColor Cyan
        Write-Host "  fm herdr                  - Launch Herdr terminal workspace" -ForegroundColor Cyan
        Write-Host "  fm bearings               - View fleet summary" -ForegroundColor Cyan
    }

    "start" {
        Write-FmBanner
        Write-Host "Launching First Mate session in '$Harness'..." -ForegroundColor Green
        Push-Location $FirstmateHome
        try {
            if ($Harness -eq "claude") {
                claude --dangerously-skip-permissions
            } elseif ($Harness -eq "pi") {
                pi
            } elseif ($Harness -eq "codex") {
                codex --full-auto
            } else {
                & $Harness
            }
        } finally {
            Pop-Location
        }
    }

    "herdr" {
        if (Get-Command herdr -ErrorAction SilentlyContinue) {
            herdr
        } else {
            Write-Warning "Herdr is not installed. Run: winget install herdr or cargo install herdr"
        }
    }

    "bearings" {
        Write-Host "Checking bearings..." -ForegroundColor Cyan
        # If bash/wsl is available, run fm-brief.sh
        if (Get-Command bash -ErrorAction SilentlyContinue) {
            bash "$FirstmateHome/bin/fm-brief.sh"
        } else {
            Write-Host "Firstmate active in $FirstmateHome" -ForegroundColor Green
        }
    }

    "help" {
        Write-FmBanner
        Write-Host "Usage:" -ForegroundColor White
        Write-Host "  fm status                  - Show fleet and toolchain status" -ForegroundColor Cyan
        Write-Host "  fm start [claude|pi|codex] - Start the First Mate liaison agent" -ForegroundColor Cyan
        Write-Host "  fm herdr                   - Launch Herdr terminal multiplexer" -ForegroundColor Cyan
        Write-Host "  fm bearings                - Digest of active work and fleet status" -ForegroundColor Cyan
    }
}

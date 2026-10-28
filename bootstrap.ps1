# =============================================================================
# bootstrap.ps1 - Kun Chen's Dotfiles & Agentic Engineering Suite for Windows
# =============================================================================
#
# Takes a fresh Windows 10/11 machine from nothing to a complete, beautiful
# agentic engineering environment matching Kun Chen's setup (WezTerm, Neovim,
# PowerShell 7, Starship, Hack Nerd Font, Claude, Codex, Pi, and /kun tooling).
#
# Run in PowerShell:
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\bootstrap.ps1
# =============================================================================

[CmdletBinding()]
param(
    [switch]$SkipPackages,
    [switch]$SkipKunTools,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$DotfilesDir = $PSScriptRoot
$HomeDir = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)

function Write-Banner {
    Write-Host ""
    Write-Host "  ██╗  ██╗██╗   ██╗███╗   ██╗" -ForegroundColor Magenta
    Write-Host "  ██║ ██╔╝██║   ██║████╗  ██║  Kun Chen's Dotfiles for Windows" -ForegroundColor Magenta
    Write-Host "  █████═╝ ██║   ██║██╔██╗ ██║  Agentic Engineering Suite" -ForegroundColor Magenta
    Write-Host "  ██╔═██╗ ██║   ██║██║╚██╗██║  WezTerm + Neovim + Starship + PS7" -ForegroundColor Magenta
    Write-Host "  ██║  ██╗╚██████╔╝██║ ╚████║  Rose Pine Moon & Claude/Codex/Pi" -ForegroundColor Magenta
    Write-Host "  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝" -ForegroundColor Magenta
    Write-Host ""
}

# --- Robust Linking Helpers (Junction, Symlink, Hardlink, or Copy) ---

function Link-Or-Copy-Directory {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Target
    )

    if (-not (Test-Path $Source)) {
        Write-Warning "Source directory does not exist: $Source"
        return
    }

    $parent = Split-Path $Target -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    # If already exists
    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        # Check if already a reparse point (junction/symlink)
        if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            # Check target
            if ($item.Target -eq $Source -or $item.LinkTarget -eq $Source) {
                Write-Host "    ✓ Directory link already in place: $Target" -ForegroundColor DarkGray
                return
            }
        }
        if ($Force) {
            Remove-Item $Target -Recurse -Force | Out-Null
        } else {
            # Backup existing
            $backup = "${Target}.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Write-Host "    ! Backing up existing $Target -> $backup" -ForegroundColor Yellow
            Rename-Item -Path $Target -NewName (Split-Path $backup -Leaf)
        }
    }

    # 1. Try Directory Junction (works for ANY standard user on NTFS without admin or Developer Mode!)
    try {
        New-Item -ItemType Junction -Path $Target -Target $Source -ErrorAction Stop | Out-Null
        Write-Host "    ✓ Linked junction: $Target -> $Source" -ForegroundColor Green
        return
    } catch {
        # 2. Try Symbolic Link
        try {
            New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
            Write-Host "    ✓ Linked symlink: $Target -> $Source" -ForegroundColor Green
            return
        } catch {
            # 3. Fallback: Copy Directory
            Copy-Item -Path $Source -Destination $Target -Recurse -Force
            Write-Host "    ✓ Copied directory: $Target" -ForegroundColor Cyan
        }
    }
}

function Link-Or-Copy-File {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Target
    )

    if (-not (Test-Path $Source)) {
        Write-Warning "Source file does not exist: $Source"
        return
    }

    $parent = Split-Path $Target -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            if ($item.Target -eq $Source -or $item.LinkTarget -eq $Source) {
                Write-Host "    ✓ File link already in place: $Target" -ForegroundColor DarkGray
                return
            }
        }
        if ($Force) {
            Remove-Item $Target -Force | Out-Null
        } else {
            $backup = "${Target}.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Rename-Item -Path $Target -NewName (Split-Path $backup -Leaf)
        }
    }

    # 1. Try Symbolic Link
    try {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
        Write-Host "    ✓ Linked symlink: $Target" -ForegroundColor Green
        return
    } catch {
        # 2. Try Hard Link
        try {
            New-Item -ItemType HardLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
            Write-Host "    ✓ Linked hardlink: $Target" -ForegroundColor Green
            return
        } catch {
            # 3. Fallback: Copy File
            Copy-Item -Path $Source -Destination $Target -Force
            Write-Host "    ✓ Copied file: $Target" -ForegroundColor Cyan
        }
    }
}

Write-Banner

# =============================================================================
# Step 1: Execution Policy & Developer Mode Hint
# =============================================================================
Write-Host "==> Step 1: Checking PowerShell environment" -ForegroundColor White

$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -eq "Restricted" -or $currentPolicy -eq "Undefined") {
    Write-Host "    Setting ExecutionPolicy for CurrentUser to RemoteSigned..." -ForegroundColor Yellow
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
}
Write-Host "    Execution policy: $(Get-ExecutionPolicy)" -ForegroundColor Green

# Ensure ~/.dotfiles symlink exists (matches Kun's Mac ~/.dotfiles pattern)
$dotfilesTarget = Join-Path $HomeDir ".dotfiles"
Link-Or-Copy-Directory -Source $DotfilesDir -Target $dotfilesTarget

# =============================================================================
# Step 2: Install CLI tools via Winget
# =============================================================================
if (-not $SkipPackages) {
    Write-Host "`n==> Step 2: Installing core packages via winget" -ForegroundColor White

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Warning "winget is not available on this machine. Please install App Installer from Microsoft Store or install packages manually."
    } else {
        $packages = @(
            @{ Id = "Microsoft.PowerShell"; Name = "PowerShell 7 (pwsh)" },
            @{ Id = "wez.wezterm"; Name = "WezTerm Terminal" },
            @{ Id = "Neovim.Neovim"; Name = "Neovim" },
            @{ Id = "BurntSushi.ripgrep.MSVC"; Name = "ripgrep (rg)" },
            @{ Id = "sharkdp.fd"; Name = "fd" },
            @{ Id = "junegunn.fzf"; Name = "fzf" },
            @{ Id = "jqlang.jq"; Name = "jq" },
            @{ Id = "JesseDuffield.lazygit"; Name = "lazygit" },
            @{ Id = "Starship.Starship"; Name = "Starship prompt" },
            @{ Id = "Hacker.HackFonts"; Name = "Hack Nerd Font" },
            @{ Id = "Git.Git"; Name = "Git for Windows" },
            @{ Id = "OpenJS.NodeJS.LTS"; Name = "Node.js LTS" }
        )

        foreach ($pkg in $packages) {
            Write-Host "    Checking $($pkg.Name)..." -NoNewline
            $installed = winget list --id $pkg.Id --exact --accept-source-agreements 2>$null
            if ($LASTEXITCODE -eq 0 -and $installed -match $pkg.Id) {
                Write-Host " already installed" -ForegroundColor DarkGray
            } else {
                Write-Host " installing..." -ForegroundColor Yellow
                winget install --id $pkg.Id --exact --silent --accept-package-agreements --accept-source-agreements
            }
        }
    }
} else {
    Write-Host "`n==> Step 2: Skipped package installation (-SkipPackages specified)" -ForegroundColor Yellow
}

# =============================================================================
# Step 3: Symlink / Wire Configurations
# =============================================================================
Write-Host "`n==> Step 3: Linking configuration files to User Profile" -ForegroundColor White

# 1. WezTerm
Write-Host "  -> WezTerm configuration" -ForegroundColor Cyan
$weztermSrcDir = Join-Path $DotfilesDir "home\.config\wezterm"
$weztermDstDir = Join-Path $HomeDir ".config\wezterm"
Link-Or-Copy-Directory -Source $weztermSrcDir -Target $weztermDstDir

$weztermSrcLua = Join-Path $weztermSrcDir "wezterm.lua"
$weztermDstLua = Join-Path $HomeDir ".wezterm.lua"
Link-Or-Copy-File -Source $weztermSrcLua -Target $weztermDstLua

# 2. Neovim
Write-Host "  -> Neovim configuration" -ForegroundColor Cyan
$nvimSrcDir = Join-Path $DotfilesDir "home\.config\nvim"
$nvimLocalApp = Join-Path $env:LOCALAPPDATA "nvim"
$nvimConfigDir = Join-Path $HomeDir ".config\nvim"
Link-Or-Copy-Directory -Source $nvimSrcDir -Target $nvimLocalApp
Link-Or-Copy-Directory -Source $nvimSrcDir -Target $nvimConfigDir

# 3. Starship
Write-Host "  -> Starship prompt configuration" -ForegroundColor Cyan
$starshipSrc = Join-Path $DotfilesDir "home\.config\starship.toml"
$starshipDst = Join-Path $HomeDir ".config\starship.toml"
Link-Or-Copy-File -Source $starshipSrc -Target $starshipDst

# 4. PowerShell Profile (PowerShell 7 and Windows PowerShell)
Write-Host "  -> PowerShell 7 profile & aliases" -ForegroundColor Cyan
$profileSrc = Join-Path $DotfilesDir "home\.config\powershell\Microsoft.PowerShell_profile.ps1"

# Target 1: CurrentUserCurrentHost for pwsh (PowerShell 7)
$pwshDocDir = Join-Path ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)) "PowerShell"
$pwshProfileDst = Join-Path $pwshDocDir "Microsoft.PowerShell_profile.ps1"
Link-Or-Copy-File -Source $profileSrc -Target $pwshProfileDst

# Target 2: Windows PowerShell 5.1 (fallback)
$winpsDocDir = Join-Path ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)) "WindowsPowerShell"
$winpsProfileDst = Join-Path $winpsDocDir "Microsoft.PowerShell_profile.ps1"
Link-Or-Copy-File -Source $profileSrc -Target $winpsProfileDst

# 5. Agent Instructions (AGENTS.md)
Write-Host "  -> Agent policies (AGENTS.md for Claude, Codex, OpenCode)" -ForegroundColor Cyan
$agentsSrc = Join-Path $DotfilesDir "home\AGENTS.md"
$claudeDir = Join-Path $HomeDir ".claude"
$codexDir = Join-Path $HomeDir ".codex"
$opencodeDir = Join-Path $HomeDir ".config\opencode"

Link-Or-Copy-File -Source $agentsSrc -Target (Join-Path $claudeDir "CLAUDE.md")
Link-Or-Copy-File -Source $agentsSrc -Target (Join-Path $claudeDir "AGENTS.md")
Link-Or-Copy-File -Source $agentsSrc -Target (Join-Path $codexDir "AGENTS.md")
Link-Or-Copy-File -Source $agentsSrc -Target (Join-Path $opencodeDir "AGENTS.md")

# 6. Claude settings.json & statusline helper
Write-Host "  -> Claude Code settings & statusline" -ForegroundColor Cyan
$claudeSettingsSrc = Join-Path $DotfilesDir "home\.claude\settings.json"
$claudeStatuslineSrc = Join-Path $DotfilesDir "home\.claude\statusline.js"
Link-Or-Copy-File -Source $claudeSettingsSrc -Target (Join-Path $claudeDir "settings.json")
Link-Or-Copy-File -Source $claudeStatuslineSrc -Target (Join-Path $claudeDir "statusline.js")

# 7. Pi Agent configuration
Write-Host "  -> Pi agent (settings, models, themes, extensions, Calm)" -ForegroundColor Cyan
$piSrcDir = Join-Path $DotfilesDir "home\.pi\agent"
$piDstDir = Join-Path $HomeDir ".pi\agent"

# Link authored directories and files
Link-Or-Copy-File -Source (Join-Path $piSrcDir "settings.json") -Target (Join-Path $piDstDir "settings.json")
Link-Or-Copy-File -Source (Join-Path $piSrcDir "models.json") -Target (Join-Path $piDstDir "models.json")
Link-Or-Copy-Directory -Source (Join-Path $piSrcDir "themes") -Target (Join-Path $piDstDir "themes")
Link-Or-Copy-Directory -Source (Join-Path $piSrcDir "extensions") -Target (Join-Path $piDstDir "extensions")

# 8. Herdr configuration
Write-Host "  -> Herdr configuration" -ForegroundColor Cyan
$herdrSrcDir = Join-Path $DotfilesDir "home\.config\herdr"
$herdrDstDir = Join-Path $HomeDir ".config\herdr"
Link-Or-Copy-Directory -Source $herdrSrcDir -Target $herdrDstDir

# =============================================================================
# Step 4: Kun Chen's Principal Engineer Agent Tooling
# =============================================================================
if (-not $SkipKunTools) {
    Write-Host "`n==> Step 4: Setting up Kun's agent skills & AXI tools" -ForegroundColor White
    $setupKunScript = Join-Path $DotfilesDir "kun-tooling\setup-kun-tools.ps1"
    if (Test-Path $setupKunScript) {
        & $setupKunScript
    }
} else {
    Write-Host "`n==> Step 4: Skipped Kun tools (-SkipKunTools specified)" -ForegroundColor Yellow
}

# =============================================================================
# Done!
# =============================================================================
Write-Host "`n============================================================" -ForegroundColor Green
Write-Host "  ✓ Bootstrap complete! Windows is configured Kun-style." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Launch WezTerm (start menu or run 'wezterm')" -ForegroundColor Gray
Write-Host "  2. In WezTerm, launch Neovim ('nvim') to auto-install lazy plugins" -ForegroundColor Gray
Write-Host "  3. Use high-agency aliases in PowerShell:" -ForegroundColor Gray
Write-Host "       cc    -> claude --dangerously-skip-permissions" -ForegroundColor Gray
Write-Host "       co    -> codex --full-auto" -ForegroundColor Gray
Write-Host "       add   -> git add ." -ForegroundColor Gray
Write-Host "       push  -> git push" -ForegroundColor Gray
Write-Host "       pull  -> git pull" -ForegroundColor Gray
Write-Host "       m     -> git switch main" -ForegroundColor Gray
Write-Host "       ..    -> cd .." -ForegroundColor Gray
Write-Host "  4. For future changes, edit files in ~/.dotfiles and run: .\rebuild.ps1`n" -ForegroundColor Gray

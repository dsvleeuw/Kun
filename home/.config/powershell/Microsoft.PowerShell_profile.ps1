# =============================================================================
# Microsoft.PowerShell_profile.ps1 - Kun Chen's agentic engineering setup for Windows
# =============================================================================

# 1. UTF-8 Console encoding for Nerd Fonts and unicode symbols
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 2. Default Editor
$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

# 3. PSReadLine (Zsh-like Autosuggestions & Syntax Highlighting)
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine

    # Ghost text suggestions from command history (matches zsh-autosuggestions)
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle InlineView

    # Accept suggestion with Ctrl+F (matches Kun's zsh: bindkey '^f' autosuggest-accept)
    # RightArrow and End also accept
    Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -Function ForwardChar

    # Rosé Pine Moon theme colors for PowerShell syntax highlighting
    Set-PSReadLineOption -Colors @{
        Command            = '#9ccfd8'  # foam (cyan/blue)
        Parameter          = '#c4a7e7'  # iris (purple)
        Operator           = '#eb6f92'  # love (pink/red)
        Variable           = '#f6c177'  # gold (yellow)
        String             = '#ebbcba'  # rose
        Number             = '#ea9a97'  # peach
        Type               = '#3e8fb0'  # pine
        Comment            = '#6e6a86'  # muted
        InlinePrediction   = '#56526e'  # subtle (ghost text)
        Selection          = '#393552'  # highlight
    }
}

# 4. Starship Prompt Initialization
$starshipConfig = Join-Path $HOME ".config\starship.toml"
if (Test-Path $starshipConfig) {
    $env:STARSHIP_CONFIG = $starshipConfig
}
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# 5. Kun Chen's Shell Aliases (matching zsh dotfiles)
function .. { Set-Location .. }
function add { git add . }
function push { git push @args }
function pull { git pull @args }
function m { git switch main }

# High-agency shortcuts
function cc { claude --dangerously-skip-permissions @args }
function co { codex --full-auto @args }

# Quality-of-life shortcuts
function lg { lazygit @args }
function v { nvim @args }
if (-not (Get-Command vim -ErrorAction SilentlyContinue)) {
    Set-Alias -Name vim -Value nvim
}

# 6. Firstmate & Lavish Launchers
function fm {
    $fmScript = Join-Path $HOME ".dotfiles\firstmate\bin\fm.ps1"
    if (-not (Test-Path $fmScript)) {
        $fmScript = Join-Path $PSScriptRoot "..\..\firstmate\bin\fm.ps1"
    }
    if (Test-Path $fmScript) {
        & $fmScript @args
    } else {
        Write-Warning "Firstmate script not found at $fmScript"
    }
}

function lavish {
    $lavishScript = Join-Path $HOME ".dotfiles\lavish-axi\bin\lavish.ps1"
    if (-not (Test-Path $lavishScript)) {
        $lavishScript = Join-Path $PSScriptRoot "..\..\lavish-axi\bin\lavish.ps1"
    }
    if (Test-Path $lavishScript) {
        & $lavishScript @args
    } else {
        npx -y lavish-axi @args
    }
}

function rebuild {
    $rebuildScript = Join-Path $HOME ".dotfiles\rebuild.ps1"
    if (-not (Test-Path $rebuildScript)) {
        $rebuildScript = Join-Path $PSScriptRoot "..\..\rebuild.ps1"
    }
    if (Test-Path $rebuildScript) {
        & $rebuildScript @args
    } else {
        Write-Warning "rebuild.ps1 not found at $rebuildScript"
    }
}

# 7. Quick Kun helper
function kun {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$KunArgs)
    $kunScript = Join-Path $HOME ".dotfiles\kun-tooling\scripts\pull-kun.mjs"
    if (-not (Test-Path $kunScript)) {
        $kunScript = Join-Path $PSScriptRoot "..\..\kun-tooling\scripts\pull-kun.mjs"
    }
    if ($KunArgs.Count -eq 0) {
        Write-Host "Kun Agentic Engineering Toolkit" -ForegroundColor Magenta
        Write-Host "  kun pull     - Sync living docs (ENTRY, TOOLS, OPINIONS, VOICE) to ~/.cache/kun"
        Write-Host "  fm           - Firstmate multi-agent fleet status"
        Write-Host "  lavish       - Open HTML artifacts in Lavish Editor"
        Write-Host "  cc           - claude --dangerously-skip-permissions"
        Write-Host "  co           - codex --full-auto"
        Write-Host "  rebuild      - Re-apply dotfiles changes"
    } elseif ($KunArgs[0] -eq "pull" -and (Test-Path $kunScript)) {
        node $kunScript
    } else {
        if (Get-Command skills -ErrorAction SilentlyContinue) {
            skills @KunArgs
        } else {
            npx -y skills @KunArgs
        }
    }
}

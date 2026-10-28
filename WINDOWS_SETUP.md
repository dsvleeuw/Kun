# Windows Setup Guide: Kun's Agentic Engineering Suite

This repository is a native Windows port of [Kun Chen's dotfiles](https://github.com/kunchenguid/dotfiles) combined with:
- **Firstmate**: Multi-agent fleet orchestrator ([kunchenguid/firstmate](https://github.com/kunchenguid/firstmate))
- **Lavish-AXI**: Interactive HTML artifact review engine ([kunchenguid/lavish-axi](https://github.com/kunchenguid/lavish-axi))
- **Kun Tooling**: Principal engineer skills and living knowledge ([kunchenguid/kun](https://github.com/kunchenguid/kun))

Everything is configured for a reproducible, beautiful, and high-agency development environment on Windows 10 and 11.

---

## 🎨 Interactive Lavish Blueprints (00 Prefix)

Before or during your setup, explore the interactive Lavish HTML artifacts in the repository root:
- **`00_OVERZICHT_ARCHITECTUUR.html`**: Master architecture, component flow, decisions matrix, and element pinpointing drawer.
- **`01_FIRSTMATE_WINDOWS_CREW.html`**: Multi-agent fleet design, Herdr backend, worktree isolation, concurrency limits.
- **`02_LAVISH_AXI_WORKFLOW.html`**: Visual artifact review loop, live interactive mockup playground, TOON feedback.
- **`03_WINDOWS_DEV_SETUP.html`**: Step-by-step verification checklist and copyable PowerShell commands.

Open any artifact in your browser or with:
```powershell
lavish .\00_OVERZICHT_ARCHITECTUUR.html
```

---

## 🚀 Fast Installation (One Command)

Open **PowerShell** (as your normal user) and run:

```powershell
git clone https://github.com/dsvleeuw/Kun.git "$HOME\.dotfiles"
cd "$HOME\.dotfiles"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\bootstrap.ps1
```

`bootstrap.ps1` will:
1. Verify and configure your PowerShell execution policy.
2. Install all CLI packages and fonts via `winget` (WezTerm, Neovim, PowerShell 7, ripgrep, fd, fzf, jq, lazygit, Starship, Hack Nerd Font, Node.js).
3. Wire your user profile configuration files via NTFS junctions and symlinks (edit-in-place).
4. Set up PowerShell 7 with Zsh-style autosuggestions (`Ctrl+F`), syntax highlighting, Starship prompt, and high-agency aliases (`cc`, `co`, `fm`, `lavish`, `add`, `push`, `pull`, `m`, `..`).
5. Wire shared `AGENTS.md` instructions for Claude Code, OpenAI Codex, and OpenCode.
6. Install and register Kun's `/kun` skill, `gh-axi`, `quota-axi`, `lavish-axi`, and `gnhf`.
7. Pull Kun's living knowledge base into `~/.cache/kun`.

---

## 📦 What is Configured

### 1. Terminal: WezTerm
- **Theme**: Rosé Pine Moon (`rose-pine-moon`).
- **Font**: Hack Nerd Font at 15.0 pt.
- **Window Opacity**: 0.8 with unfocused window dimming (focused window stands out instantly).
- **Default Shell**: Automatically launches PowerShell 7 (`pwsh.exe -NoLogo`).
- **Config Path**: `~/.wezterm.lua` and `~/.config/wezterm/wezterm.lua`.

### 2. Editor: Neovim
- **Theme**: Rosé Pine Moon with transparent background enabled on Windows.
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) (bootstraps automatically on first run).
- **Plugins**:
  - `oil.nvim`: File navigation (`<leader>e`).
  - `snacks.nvim`: Fast picker (`<leader>f` files, `<leader>s` grep, `<leader>b` buffers, `gd` LSP definitions).
  - `neogit` & `diffview.nvim`: Git UI (`<leader>g`).
  - `gitsigns.nvim`: Inline git blame (`current_line_blame`).
  - `which-key.nvim`: Leader key helper popups.
- **Keybindings**:
  - `<Esc>`: Quick save file (`:w<CR>`).
  - `<C-a>`: Select all (`ggVG`).
  - System clipboard sharing with Windows (`clipboard = 'unnamedplus'`).
- **Config Path**: `$env:LOCALAPPDATA\nvim` and `~/.config/nvim`.

### 3. Shell: PowerShell 7 & Starship
- **Prompt**: Starship matching Kun's clean style with purple arrow `[❯](purple)` on success, red on error.
- **Autosuggestions**: Powered by `PSReadLine` with command history predictions (matches `zsh-autosuggestions`).
- **Suggestion Accept Key**: Press `Ctrl+F` to accept the suggestion (matches Kun's `bindkey '^f' autosuggest-accept`), or use `RightArrow` / `End`.
- **Syntax Coloring**: Styled with Rosé Pine Moon colors.
- **Aliases**:
  - `cc`: `claude --dangerously-skip-permissions` (high-agency shortcut)
  - `co`: `codex --full-auto` (high-agency shortcut)
  - `fm`: Firstmate fleet launcher (`fm status`, `fm start`, `fm herdr`, `fm bearings`)
  - `lavish`: Lavish Editor launcher (`lavish <file.html>`)
  - `add`: `git add .`
  - `push`: `git push`
  - `pull`: `git pull`
  - `m`: `git switch main`
  - `..`: `cd ..`
  - `lg`: `lazygit`
  - `v` / `vim`: `nvim`
  - `kun`: helper for Kun's skills and living docs (`kun pull`)
  - `rebuild`: re-applies dotfiles configuration

### 4. Autonomous Agent Policies (`AGENTS.md`)
Kun's global agent directives are shared across all your coding agents:
- **No em dashes**: Never use "-", use plain dash "-" instead.
- **No co-author spam**: Never auto-add agent co-author trailers in commit messages.
- **UI Pixel Perfection**: Obsessed with UI pixel perfection during end-to-end tests.
- **E2E Bug Reproduction**: Reproduce bugs in end-to-end user-like scenarios before writing fixes.
- **No swarm surprises**: Explain tradeoffs and get approval before spawning large subagent swarms.

### 5. Multi-Agent Fleet: Firstmate (`firstmate/`)
- Run an entire fleet of autonomous agents in parallel.
- Talks to one First Mate liaison agent; spawns crewmates in isolated git worktrees (`treehouse`).
- Herdr terminal multiplexer manages visible panes.
- Zero-token watcher sleeps without consuming LLM API calls.

### 6. Visual Review: Lavish-AXI (`lavish-axi/`)
- Open HTML artifacts in your local browser.
- Click any element to pinpoint changes.
- Highlight text for inline diff suggestions.
- Mermaid flowcharts become live editable Excalidraw whiteboards.

---

## 🔄 Daily Workflow

Because files are linked to your repository:
- **Edit in place**: Changing files in `~/.dotfiles/home/` immediately reflects in your tools.
- **Apply updates**: Run `rebuild` from PowerShell to re-apply any changed paths or update configs.
- **Update Kun's knowledge**: Run `kun pull` to sync the latest daily insights from Kun Chen's live repository into `~/.cache/kun`.

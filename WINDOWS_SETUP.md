# Windows Setup Guide: Kun's Agentic Engineering Suite

This repository is a native Windows port of [Kun Chen's dotfiles](https://github.com/kunchenguid/dotfiles) combined with Kun's principal engineer tooling ([kunchenguid/kun](https://github.com/kunchenguid/kun)).

Everything is configured for a reproducible, beautiful, and high-agency development environment on Windows 10 and 11.

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
4. Set up PowerShell 7 with Zsh-style autosuggestions (`Ctrl+F`), syntax highlighting, Starship prompt, and high-agency aliases (`cc`, `co`, `add`, `push`, `pull`, `m`, `..`).
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
  - `add`: `git add .`
  - `push`: `git push`
  - `pull`: `git pull`
  - `m`: `git switch main`
  - `..`: `cd ..`
  - `lg`: `lazygit`
  - `v` / `vim`: `nvim`
  - `kun`: helper for Kun's skills and living docs (`kun pull`)

### 4. Autonomous Agent Policies (`AGENTS.md`)
Kun's global agent directives are shared across all your coding agents:
- **No em dashes**: Never use "—", use plain dash "-" instead.
- **No co-author spam**: Never auto-add agent co-author trailers in commit messages.
- **UI Pixel Perfection**: Obsessed with UI pixel perfection during end-to-end tests.
- **E2E Bug Reproduction**: Reproduce bugs in end-to-end user-like scenarios before writing fixes.
- **No swarm surprises**: Explain tradeoffs and get approval before spawning large subagent swarms.
- **Linked paths**:
  - Claude: `~/.claude/CLAUDE.md` and `~/.claude/AGENTS.md`
  - Codex: `~/.codex/AGENTS.md`
  - OpenCode: `~/.config/opencode/AGENTS.md`

### 5. Claude Code Configuration
- **Theme**: `dark-ansi`.
- **StatusLine**: Live model display and context window utilization percentage (`Claude 3.7 Sonnet | ctx: 42% used`).
- Implemented with a cross-platform inline Node runner that works natively on Windows without bash/jq dependencies.

### 6. Pi Coding Agent
- **Theme**: Rosé Pine Moon (`home/.pi/agent/themes/rose-pine-moon.json`).
- **Pi Calm**: Standalone local extension that hides noisy tool output and collapsed thinking, rendering a calm animated yellow ship on blue water during active runs. Toggle with `/calm`.
- **Terminal Status Title**: Live spinner and task status in terminal tab title.
- **Pinned Packages**:
  - `npm:pi-web-access@0.14.0` (web browsing)
  - `npm:@ryan_nookpi/pi-extension-codex-fast-mode@0.2.6`

### 7. Kun Chen's Principal Engineer Stack (`/kun` & AXI)
- **`/kun` Skill**: Direct access to Kun Chen's principal-engineer knowledge base inside Claude Code, Codex, and Grok.
  ```sh
  /kun how should I structure my AGENTS.md?
  /kun what are the trade-offs of this architecture?
  ```
- **`gh-axi`**: Token-efficient GitHub CLI for agents with TOON output.
- **`quota-axi`**: Unified subscription quota viewer across Claude, Codex, Cursor, Grok (`quota-axi`).
- **`lavish-axi`**: Browser-based HTML artifact & Mermaid diagram collaborative editor.
- **`gnhf`**: "Good night, have fun" overnight autonomous agentic coding loops.

---

## 🔄 Daily Workflow

Because files are linked to your repository:
- **Edit in place**: Changing files in `~/.dotfiles/home/` immediately reflects in your tools.
- **Apply updates**: Run `.\rebuild.ps1` from PowerShell to re-apply any changed paths or update configs.
- **Update Kun's knowledge**: Run `kun pull` to sync the latest daily insights from Kun Chen's live repository into `~/.cache/kun`.

---

## ❓ Troubleshooting & FAQs

### How do symlinks work on Windows?
`bootstrap.ps1` uses **NTFS Junctions** for directories (`New-Item -ItemType Junction`). Junctions work on Windows for all standard users without requiring Administrator elevation and without Developer Mode.

If you enable Windows **Developer Mode** (Settings > System > For Developers > Developer Mode: On), file symbolic links can also be created without admin privileges. If Developer Mode is off, `bootstrap.ps1` automatically uses hardlinks or fast sync copies.

### Font not rendering icons?
If icons look like boxes after installing:
1. Close all terminal windows.
2. Open WezTerm (which uses `Hack Nerd Font` by default).
3. If using Windows Terminal, set Font face to `Hack Nerd Font` in Settings > Defaults > Appearance.

### How to use with WSL2?
If you also use WSL2 on the same machine, you can run `./home.nix` with Nix/Home Manager inside WSL, or run WezTerm on Windows set to open WSL as a tab alongside PowerShell!

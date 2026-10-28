# Kun Chen Dotfiles & Agentic Engineering Suite (Windows)

<p align="center">
  <a href="https://discord.gg/Wsy2NpnZDu"
    ><img
      alt="Discord"
      src="https://img.shields.io/discord/1439901831038763092?style=flat-square&label=discord"
  /></a>
  <a href="https://linktr.ee/kunchenguid"
    ><img
      alt="Kun Chen"
      src="https://img.shields.io/badge/Kun%20Chen-Principal%20Engineer-purple?style=flat-square"
  /></a>
</p>

De ultieme Windows coding repository voor **agentic engineering**, gebaseerd op het complete ecosysteem van Kun Chen (voormalig L8 Principal Engineer bij Meta, Microsoft en Atlassian):
- **Dotfiles**: WezTerm, Neovim (transparant), PowerShell 7, Starship prompt en Hack Nerd Font.
- **Firstmate Distro**: Multi-agent fleet orchestratie ("Talk to one agent. Ship with a crew") met worktrees en Herdr.
- **Lavish-AXI**: Browser-gebaseerde interactieve review van HTML-artefacten, element pinpointing en Mermaid whiteboards.
- **Kun Tooling**: `/kun` skill, `gh-axi`, `quota-axi`, `gnhf`, `treehouse` en de levende kennisbank.

---

## 🎨 Interactieve Lavish Artefacten (00 Prefix)

Deze repository bevat interactieve **Lavish HTML artefacten** waarin je alle stappen visueel kunt bekijken, op elementen kunt klikken, beslissingen kunt kiezen en gestructureerde suggesties kunt achterlaten voor je agents:

| Bestand | Wat het visualiseert | Interactieve Mogelijkheden |
|---|---|---|
| **[`00_OVERZICHT_ARCHITECTUUR.html`](00_OVERZICHT_ARCHITECTUUR.html)** | Master Architectuur & Windows Stack Blueprint | Interactief SVG schema, beslissingsmatrix (terminal, backend, merge autonomie), element pinpointing drawer |
| **[`01_FIRSTMATE_WINDOWS_CREW.html`](01_FIRSTMATE_WINDOWS_CREW.html)** | Firstmate Multi-Agent Fleet & Worktrees | Spawnen van parallelle crewmates, Herdr sessies, worktree isolatie, concurrency keuzes |
| **[`02_LAVISH_AXI_WORKFLOW.html`](02_LAVISH_AXI_WORKFLOW.html)** | Lavish-AXI Review Engine & Whiteboards | Live demo playground, tekstmarkering, Mermaid whiteboards, TOON feedback |
| **[`03_WINDOWS_DEV_SETUP.html`](03_WINDOWS_DEV_SETUP.html)** | Step-by-Step Windows Uitrol & Verificatie | Installatievolgorde, winget commando's, verificatietabel, profiel checks |

> **Tip:** Open elk bestand direct in je browser of via het `lavish` commando:
> ```powershell
> lavish .\00_OVERZICHT_ARCHITECTUUR.html
> ```

---

## 🇳🇱 Snelle Installatie op Windows (Quick Start)

Open **PowerShell** en voer het volgende uit:

```powershell
git clone https://github.com/dsvleeuw/Kun.git "$HOME\.dotfiles"
cd "$HOME\.dotfiles"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\bootstrap.ps1
```

`bootstrap.ps1` verzorgt de complete installatie:
1. **Winget pakketten**: Installeert PowerShell 7 (`pwsh`), WezTerm, Neovim, ripgrep (`rg`), `fd`, `fzf`, `jq`, `lazygit`, Starship prompt, Hack Nerd Font en Node.js LTS.
2. **Koppeling configuraties**: Maakt NTFS-junctions en symlinks aan naar je Windows `$HOME` (`C:\Users\<user>`), waardoor bewerkingen in de repository direct live actief zijn (*edit-in-place*).
3. **PowerShell 7 profiel**: Configureert Zsh-stijl autosuggesties (`Ctrl+F` om te accepteren), syntax highlighting in Rosé Pine Moon-kleuren, Starship prompt en Kun's aliassen.
4. **Firstmate & Lavish Launchers**: Activeert de `fm` en `lavish` commandoregels direct in PowerShell.
5. **Agent-beleid (`AGENTS.md`)**: Universeel gekoppeld aan Claude Code, OpenAI Codex en OpenCode.
6. **Kun Tooling**: Installeert de `/kun` skill, `gh-axi`, `quota-axi`, `lavish-axi`, `gnhf` en synchroniseert Kun's levende documentatie naar `~/.cache/kun`.

---

## 📦 Wat er allemaal in zit

| Component | Configuratie & Eigenschappen |
|---|---|
| **Terminal** | **WezTerm** in Rosé Pine Moon thema, Hack Nerd Font (15pt), 0.8 opacity, unfocused window dimming, start direct in PowerShell 7 (`pwsh.exe`). |
| **Editor** | **Neovim** met transparante achtergrond op Windows, lazy.nvim, Oil.nvim (`<leader>e`), Snacks.picker (`<leader>f` files, `<leader>s` grep, `<leader>b` buffers, `gd` definities), Neogit & Diffview (`<leader>g`), Gitsigns blame. |
| **Shell** | **PowerShell 7** met PSReadLine autosuggesties (`Ctrl+F`), Rosé Pine Moon syntaxkleuren en Starship prompt (`[❯](purple)` / `[❯](red)`). |
| **Firstmate Fleet** | **`firstmate/`**: Praat met 1 First Mate agent die parallelle werkers in geïsoleerde git worktrees aanstuurt via Herdr of tmux. Commando: `fm status`, `fm start`. |
| **Lavish-AXI** | **`lavish-axi/`**: Visuele HTML artefact review, annotaties en Mermaid whiteboards. Commando: `lavish <bestand.html>`. |
| **Aliassen** | `cc` (`claude --dangerously-skip-permissions`), `co` (`codex --full-auto`), `fm` (Firstmate), `lavish` (Lavish Editor), `add`, `push`, `pull`, `m` (`git switch main`), `..` (`cd ..`), `lg` (`lazygit`), `v` (`nvim`). |
| **Agent Policies** | **`AGENTS.md`** voor Claude, Codex en OpenCode (geen em dash "-", geen automatische co-author spam, obsessie met pixel-perfect UI, end-to-end bug reproductie). |
| **Claude Code** | `dark-ansi` thema met live statusregel: modelnaam en contextvenster gebruik (`Claude 3.7 Sonnet \| ctx: 42% used`) via een cross-platform runner. |
| **Pi Coding Agent** | **Pi Calm** standalone extensie (geanimeerd bootje op blauw water, verbergt ruis van tools en thinking blocks), Rosé Pine Moon thema, terminal status spinner, gepinde packages (`pi-web-access@0.14.0`, `codex-fast-mode@0.2.6`). |
| **Kun Tooling** | **`/kun`** skill (`npx skills add kunchenguid/kun -g`), `gh-axi`, `quota-axi`, `lavish-axi`, `gnhf`, `treehouse` en lokale kennisbank. |

---

## ⚓ Firstmate op Windows (`firstmate/`)

Firstmate is een agent distro waarmee je praat met één liaison agent (de First Mate) die zelfstandig een team van gespecialiseerde crewmates aanstuurt:
```powershell
# Bekijk de status van je vloot en tools
fm status

# Start de First Mate supervisor sessie in Claude Code
fm start claude

# Bekijk overzicht van actieve taken en PRs
fm bearings
```

Elke worker krijgt een eigen geïsoleerde git worktree (`treehouse`), waardoor meerdere agents gelijktijdig aan dezelfde repository kunnen werken zonder mergeconflicten.

---

## 🎨 Lavish-AXI Review Engine (`lavish-axi/`)

In plaats van ellenlange teksten in de terminal levert je agent interactieve HTML artefacten die je opent met:
```powershell
lavish .\00_OVERZICHT_ARCHITECTUUR.html
```
- **Klik op elementen** om gerichte feedback achter te laten.
- **Markeer tekst** om direct een herschrijving voor te stellen.
- **Mermaid diagrammen** worden interactieve whiteboards die je visueel kunt aanpassen.
- **Klik op "Kopieer Feedback voor Agent"** om de samenvatting in één keer terug te sturen.

---

## 🔄 Dagelijks Gebruik

- **Bestanden aanpassen**: Pas bestanden aan in `~/.dotfiles/home/` en voer `rebuild` uit.
- **Kennisbank updaten**: Voer `kun pull` uit in PowerShell om de nieuwste meningen en tools van Kun Chen binnen te halen.

Zie [`WINDOWS_SETUP.md`](WINDOWS_SETUP.md) voor de complete handleiding en troubleshooting.

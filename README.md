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

Een complete, 100% native Windows-port van [Kun Chen's dotfiles](https://github.com/kunchenguid/dotfiles) gecombineerd met Kun's Principal Engineer agent-stack ([kunchenguid/kun](https://github.com/kunchenguid/kun)).

Eén repository, één PowerShell-commando (`bootstrap.ps1`), en een Windows 10/11 machine is direct ingericht voor moderne **agentic engineering** met WezTerm, Neovim, PowerShell 7, Starship, Claude Code, Codex, Pi en Kun's AXI tools.

---

## 🇳🇱 Snelle Installatie op Windows (Quick Start)

Open **PowerShell** en voer het volgende uit:

```powershell
git clone https://github.com/dsvleeuw/Kun.git "$HOME\.dotfiles"
cd "$HOME\.dotfiles"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\bootstrap.ps1
```

`bootstrap.ps1` voert automatisch uit:
1. **Winget pakketinstallatie**: PowerShell 7 (`pwsh`), WezTerm, Neovim, ripgrep, fd, fzf, jq, lazygit, Starship prompt, Hack Nerd Font en Node.js LTS.
2. **Koppeling configuraties**: Maakt NTFS-junctions en symlinks aan naar je gebruikersmap (`$HOME` / `~`).
3. **PowerShell 7 profiel**: Configureert Zsh-stijl autosuggesties (accepteren met `Ctrl+F`), syntax highlighting in Rosé Pine Moon stijl, Starship prompt en high-agency aliassen (`cc`, `co`, `add`, `push`, `pull`, `m`, `..`).
4. **Agent beleid (`AGENTS.md`)**: Universeel gekoppeld aan Claude Code, OpenAI Codex en OpenCode.
5. **Kun Chen Tooling**: Installeert de `/kun` skill, `gh-axi`, `quota-axi`, `lavish-axi` en synchroniseert Kun's levende documentatie (`ENTRY`, `TOOLS`, `OPINIONS`, `VOICE`) naar `~/.cache/kun`.

---

## 📦 Wat je krijgt

| Component | Configuratie & Eigenschappen |
|---|---|
| **Terminal** | **WezTerm** in Rosé Pine Moon thema, Hack Nerd Font (15pt), 0.8 opacity, unfocused window dimming, start direct in PowerShell 7 (`pwsh.exe`). |
| **Editor** | **Neovim** met transparante achtergrond op Windows, lazy.nvim, Oil.nvim (`<leader>e`), Snacks.picker (`<leader>f` files, `<leader>s` grep, `<leader>b` buffers, `gd` definitions), Neogit & Diffview (`<leader>g`), Gitsigns blame. |
| **Shell** | **PowerShell 7** met PSReadLine autosuggesties (`Ctrl+F`), Rosé Pine Moon syntaxkleuren en Starship prompt (`[❯](purple)` / `[❯](red)`). |
| **Aliassen** | `cc` (`claude --dangerously-skip-permissions`), `co` (`codex --full-auto`), `add` (`git add .`), `push` (`git push`), `pull` (`git pull`), `m` (`git switch main`), `..` (`cd ..`), `lg` (`lazygit`), `v` (`nvim`). |
| **Agent Policies** | **`AGENTS.md`** voor Claude, Codex en OpenCode (geen em dash "—", geen automatische co-author spam, obsessie met pixel-perfect UI, end-to-end bug reproductie). |
| **Claude Code** | `dark-ansi` thema met live statusregel: modelnaam en contextvenster gebruik (`Claude 3.7 Sonnet \| ctx: 42% used`) via een cross-platform runner. |
| **Pi Coding Agent** | **Pi Calm** standalone extensie (geanimeerd bootje op blauw water, verbergt ruis van tools en thinking blocks), Rosé Pine Moon thema, terminal status spinner, gepinde packages (`pi-web-access@0.14.0`, `codex-fast-mode@0.2.6`). |
| **Kun Tooling** | **`/kun`** skill (`npx skills add kunchenguid/kun -g`), `gh-axi`, `quota-axi`, `lavish-axi`, `gnhf`, `treehouse` en lokale kennisbank. |

---

## 🧠 Kun Chen's Principal Engineer Stack (`/kun`)

Kun Chen (voormalig L8 Principal Engineer bij Meta, Microsoft en Atlassian) ontwikkelde een geavanceerde set AXI (Agent eXperience Interface) tools en richtlijnen voor softwareontwikkeling met AI-agents:

### Direct Kun oproepen in je coding agent:
```sh
/kun how should I improve my AGENTS.md?
/kun fix this nasty bug!
/kun how would you architect this service?
```

### Belangrijkste AXI tools inbegrepen:
- **`gh-axi`**: Token-efficiënte GitHub CLI voor agents met TOON output.
- **`quota-axi`**: Bekijk je resterende LLM-quota en gebruiksvensters over Claude, Codex, Cursor en Grok (`quota-axi`).
- **`lavish-axi`**: Lokale browser editor voor interactieve HTML-artefacten en Mermaid diagrammen van agents.
- **`gnhf`**: *"Good night, have fun"* — autonome overnight coding loop met automatische rollbacks bij fouten.
- **`treehouse`**: Git worktree pooling voor parallel werkende agents.

Voor meer details, zie [`kun-tooling/README.md`](kun-tooling/README.md).

---

## 🔄 Dagelijks Gebruik

Omdat alle bestanden via links aan deze repository zijn gekoppeld:
- Pas je bestanden direct aan in `~/.dotfiles/home/`.
- Voer bij wijzigingen in PowerShell uit:
  ```powershell
  .\rebuild.ps1
  ```
- Werk Kun's levende kennisbank bij met:
  ```powershell
  kun pull
  ```

---

## 📁 Repository Structuur

```
Kun/
├── AGENTS.md                  # Projectrichtlijnen voor agents
├── CLAUDE.md                  # Importeert AGENTS.md
├── LICENSE                    # MIT No Attribution License
├── README.md                  # Dit document
├── WINDOWS_SETUP.md           # Uitgebreide Windows handleiding & troubleshooting
├── bootstrap.ps1              # Volledig Windows installatiescript (winget + links + profielen)
├── rebuild.ps1                # Re-sync script voor Windows
├── home/                      # De daadwerkelijke configuratiebestanden
│   ├── AGENTS.md              # Kun's wereldwijde agent instructies
│   ├── .claude/
│   │   ├── settings.json      # Claude Code instellingen (statusLine met ctx % en model)
│   │   └── statusline.js      # Cross-platform Node statusline helper
│   ├── .config/
│   │   ├── herdr/             # Herdr workspace multiplexer config
│   │   ├── nvim/              # Neovim (lazy.nvim, rose-pine moon, snacks, oil, neogit)
│   │   ├── powershell/        # PowerShell 7 profiel met PSReadLine & aliassen
│   │   ├── starship.toml      # Starship prompt configuratie
│   │   └── wezterm/           # WezTerm terminal configuratie (rose-pine-moon, pwsh)
│   └── .pi/
│       └── agent/             # Pi agent (settings, models, themes, Pi Calm extensie)
├── kun-tooling/               # Kun Chen's Principal Engineer kennisbank & tools
│   ├── README.md              # Uitleg over Kun's tooling
│   ├── setup-kun-tools.ps1    # Installatiescript voor AXI tools & /kun skill
│   ├── ENTRY.md               # Kun's instructies voor taakoplossing
│   ├── TOOLS.md               # Overzicht van alle open source tools
│   ├── OPINIONS.md            # Kun's visie op architecturen, agents en engineering
│   ├── VOICE.md               # Kun's schrijf- en communicatiestijl
│   └── scripts/
│       └── pull-kun.mjs       # Incrementeel sync-script voor Kun's living docs
└── tests/
    ├── validate-configs.mjs   # Geautomatiseerde configuratievalidatie
    └── test-statusline.mjs    # Testsuite voor de Claude statusregel
```

---

## 📄 Licentie

Gelicentieerd onder **MIT No Attribution** (zie `LICENSE`), in lijn met het originele dotfiles-project van Kun Chen.

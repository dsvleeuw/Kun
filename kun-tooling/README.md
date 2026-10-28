# Kun Chen's Principal Engineer Toolkit on Windows

This directory vendors and integrates **Kun Chen's** (`kunchenguid/kun`) knowledge base, workflows, and AXI tools for Windows developers.

Kun Chen is a former L8 Principal Engineer at Meta, Microsoft, and Atlassian. His stack is designed for **agentic engineering**: building software with autonomous coding agents (Claude Code, OpenAI Codex, Grok Bot, Pi) with high agency, minimal token waste, and principal-grade code quality.

---

## ⚡ Quick Start on Windows

Run the PowerShell installer to set up all skills and tools:

```powershell
.\kun-tooling\setup-kun-tools.ps1
```

Once installed, summon Kun's persona, experience, and opinions inside any agent session:

```sh
/kun how should I improve my AGENTS.md?
/kun fix this nasty bug!
/kun how would you architect a service that...?
```

---

## 🛠️ The Kun Chen Tooling Stack

| Tool / Skill | What it does | How to use on Windows |
|---|---|---|
| **`/kun`** | Living distillation of Kun's experience, daily updated opinions, and workflows | `npx skills add kunchenguid/kun -g` then `/kun <question>` |
| **`gh-axi`** | AXI GitHub CLI: token-efficient wrapper around `gh` with TOON output | `npx skills add kunchenguid/gh-axi --skill gh-axi -g` |
| **`quota-axi`** | View remaining subscription quota windows across Claude, Codex, Cursor, Grok, etc. | `npm install -g quota-axi` → `npx -y quota-axi` |
| **`lavish-axi`** | Interactive HTML artifact review & Mermaid diagram editor in local browser | `npx skills add kunchenguid/lavish-axi --skill lavish` |
| **`gnhf`** | "Good night, have fun" — overnight autonomous agentic coding loop with rollback | `npm install -g gnhf` → `gnhf "objective"` |
| **`treehouse`** | Pooled reusable git worktrees so each agent gets an isolated tree instantly | `treehouse` |
| **`no-mistakes`** | Local git proxy gate running review/test/lint before branch forwarding | `no-mistakes init` → `git push no-mistakes` |

---

## 📚 Living Documentation Included

The four foundational living documents from Kun Chen's repo are mirrored here:

- **`ENTRY.md`**: Guide for agents on how to answer when `/kun` is invoked (research, planning, reproduction, guardrails, implementation, validation).
- **`TOOLS.md`**: Detailed index of Kun's public tools, the problems they solve, and usage instructions.
- **`OPINIONS.md`**: 110+ KB comprehensive map of Kun's technical viewpoints, tradeoffs, context compaction strategies, and agent ergonomics.
- **`VOICE.md`**: Kun's authentic communication voice and writing style.

### Keeping Knowledge Fresh
Run the incremental sync script at any time:
```powershell
node .\kun-tooling\scripts\pull-kun.mjs
```
This downloads remote updates from `kunchenguid/kun@main` into `~/.cache/kun` without requiring any API keys.

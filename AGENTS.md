# Project notes for agents

Deliberate decisions in this repository - do not silently revert them:

- This repo is a 100% native Windows port of Kun Chen's agentic engineering dotfiles (kunchenguid/dotfiles) combined with Kun's principal engineer tooling (kunchenguid/kun).
- WezTerm default_prog is configured for PowerShell 7 (pwsh.exe) with fallback to Windows PowerShell.
- Directory links use NTFS Junctions (`New-Item -ItemType Junction`) by default, because junctions work on Windows for any standard user without requiring Administrator elevation or Developer Mode.
- StatusLine for Claude Code uses a cross-platform inline Node.js runner to prevent dependency on bash/jq on Windows hosts.
- Never use the em dash "-" in any file or commit message. Use plain dash "-" instead.
- Never commit validation artifacts or secret keys.

## Maintaining this file

Keep this file for knowledge useful to future agent sessions in this project.
Do not repeat what the codebase already shows; point to the authoritative file or command instead.
Prefer rewriting or pruning existing entries over appending new ones.
When updating this file, preserve this bar for all agents and keep entries concise.

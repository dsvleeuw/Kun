import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join, extname } from 'node:path';
import { spawnSync } from 'node:child_process';
import assert from 'node:assert';

const ROOT = join(process.cwd());

function getAllFiles(dir, extFilter = null) {
  let results = [];
  const list = readdirSync(dir);
  for (const file of list) {
    if (file === '.git' || file === 'node_modules') continue;
    const filePath = join(dir, file);
    const stat = statSync(filePath);
    if (stat && stat.isDirectory()) {
      results = results.concat(getAllFiles(filePath, extFilter));
    } else {
      if (!extFilter || extFilter.includes(extname(filePath))) {
        results.push(filePath);
      }
    }
  }
  return results;
}

console.log('Validating repository configurations...');

// 1. JSON files
const jsonFiles = getAllFiles(ROOT, ['.json']);
for (const file of jsonFiles) {
  const content = readFileSync(file, 'utf8');
  try {
    JSON.parse(content);
    console.log(`  ✓ Valid JSON: ${file.replace(ROOT, '')}`);
  } catch (err) {
    console.error(`  ✗ Invalid JSON: ${file}: ${err.message}`);
    process.exit(1);
  }
}

// 2. JS files syntax check
const jsFiles = getAllFiles(ROOT, ['.js', '.mjs']);
for (const file of jsFiles) {
  const check = spawnSync(process.execPath, ['--check', file], { encoding: 'utf8' });
  if (check.status !== 0) {
    console.error(`  ✗ JavaScript syntax error in ${file}:\n${check.stderr}`);
    process.exit(1);
  } else {
    console.log(`  ✓ Valid JS syntax: ${file.replace(ROOT, '')}`);
  }
}

// 3. Global AGENTS.md checks (verify key sections)
const globalAgentsMdPath = join(ROOT, 'home', 'AGENTS.md');
const globalAgentsMd = readFileSync(globalAgentsMdPath, 'utf8');
assert(globalAgentsMd.includes('Never use the em dash'), 'home/AGENTS.md contains policy');
assert(globalAgentsMd.includes('pixel perfection'), 'home/AGENTS.md mentions UI pixel perfection');
console.log('  ✓ home/AGENTS.md follows Kun Chen rules');

// 4. Wezterm lua check
const weztermLua = readFileSync(join(ROOT, 'home', '.config', 'wezterm', 'wezterm.lua'), 'utf8');
assert(weztermLua.includes('rose-pine-moon'), 'wezterm.lua specifies rose-pine-moon');
assert(weztermLua.includes('pwsh.exe'), 'wezterm.lua defaults to PowerShell 7 on Windows');
console.log('  ✓ wezterm.lua configured for Windows pwsh & rose-pine-moon');

// 5. Neovim config check
const colorschemeLua = readFileSync(join(ROOT, 'home', '.config', 'nvim', 'lua', 'plugins', 'colorscheme.lua'), 'utf8');
assert(colorschemeLua.includes('rose-pine'), 'Neovim specifies rose-pine');
assert(colorschemeLua.includes('Windows'), 'Neovim colorscheme supports Windows transparency');
console.log('  ✓ Neovim config configured for rose-pine & Windows transparency');

// 6. PowerShell Profile check
const psProfile = readFileSync(join(ROOT, 'home', '.config', 'powershell', 'Microsoft.PowerShell_profile.ps1'), 'utf8');
assert(psProfile.includes('starship init powershell'), 'PowerShell profile initializes Starship');
assert(psProfile.includes('PSReadLine'), 'PowerShell profile configures PSReadLine');
assert(psProfile.includes('function cc'), 'PowerShell profile defines cc alias');
assert(psProfile.includes('function co'), 'PowerShell profile defines co alias');
console.log('  ✓ PowerShell profile contains all required aliases & settings');

// 7. bootstrap.ps1 exists and contains package definitions
const bootstrapPs1 = readFileSync(join(ROOT, 'bootstrap.ps1'), 'utf8');
assert(bootstrapPs1.includes('Microsoft.PowerShell'), 'bootstrap.ps1 includes pwsh');
assert(bootstrapPs1.includes('wez.wezterm'), 'bootstrap.ps1 includes wezterm');
assert(bootstrapPs1.includes('Neovim.Neovim'), 'bootstrap.ps1 includes neovim');
assert(bootstrapPs1.includes('firstmate'), 'bootstrap.ps1 links firstmate');
assert(bootstrapPs1.includes('lavish-axi'), 'bootstrap.ps1 links lavish-axi');
console.log('  ✓ bootstrap.ps1 contains core winget package definitions & firstmate/lavish links');

// 8. Lavish HTML artifacts check (00_, 01_, 02_, 03_)
const lavishArtifacts = [
  '00_OVERZICHT_ARCHITECTUUR.html',
  '01_FIRSTMATE_WINDOWS_CREW.html',
  '02_LAVISH_AXI_WORKFLOW.html',
  '03_WINDOWS_DEV_SETUP.html'
];
for (const artifact of lavishArtifacts) {
  const content = readFileSync(join(ROOT, artifact), 'utf8');
  assert(content.includes('<!DOCTYPE html>'), `${artifact} is valid HTML5`);
  assert(content.includes('clickable-node'), `${artifact} contains clickable elements for user feedback`);
  assert(content.includes('addSuggestion'), `${artifact} contains suggestion engine`);
  console.log(`  ✓ Lavish artifact ${artifact} verified (clickable + suggestions)`);
}

console.log('\nAll configurations validated successfully!');

import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import assert from 'node:assert';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const statuslineScript = join(__dirname, '..', 'home', '.claude', 'statusline.js');

function runStatusline(input) {
  const result = spawnSync(process.execPath, [statuslineScript], {
    input,
    encoding: 'utf8',
  });
  return result.stdout;
}

console.log('Testing statusline.js...');

// 1. Full input
const fullInput = JSON.stringify({
  model: { display_name: 'Claude 3.7 Sonnet' },
  context_window: { used_percentage: 42.4 },
});
assert.strictEqual(runStatusline(fullInput), 'Claude 3.7 Sonnet | ctx: 42% used');
console.log('  ✓ Formats model and context percentage correctly');

// 2. High percentage rounded
const highInput = JSON.stringify({
  model: { display_name: 'Claude 3.5 Haiku' },
  context_window: { used_percentage: 89.6 },
});
assert.strictEqual(runStatusline(highInput), 'Claude 3.5 Haiku | ctx: 90% used');
console.log('  ✓ Rounds percentage correctly');

// 3. Model only without context
const modelOnlyInput = JSON.stringify({
  model: { display_name: 'Claude 3.7 Sonnet' },
});
assert.strictEqual(runStatusline(modelOnlyInput), 'Claude 3.7 Sonnet');
console.log('  ✓ Handles missing context window percentage');

// 4. Model ID fallback if display_name is missing
const fallbackIdInput = JSON.stringify({
  model: { id: 'claude-3-7-sonnet-20250219' },
});
assert.strictEqual(runStatusline(fallbackIdInput), 'claude-3-7-sonnet-20250219');
console.log('  ✓ Falls back to model id');

// 5. Empty or malformed input doesn't crash
assert.strictEqual(runStatusline(''), '');
assert.strictEqual(runStatusline('{invalid-json}'), '');
console.log('  ✓ Gracefully handles invalid/empty input without throwing');

console.log('All statusline tests passed!');

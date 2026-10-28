#!/usr/bin/env node
/**
 * Claude Code statusLine formatter.
 * Reads JSON session info from stdin and prints:
 * "<model> | ctx: <used>% used" or "<model>"
 * Works cross-platform on Windows, macOS, and Linux without bash/jq dependencies.
 */
let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => { input += chunk; });
process.stdin.on('end', () => {
  try {
    if (!input.trim()) return;
    const data = JSON.parse(input.trim());
    const model = data?.model?.display_name || data?.model?.id || '';
    const used = data?.context_window?.used_percentage;
    if (used !== undefined && used !== null && used !== '') {
      const pct = Math.round(Number(used));
      process.stdout.write(`${model} | ctx: ${pct}% used`);
    } else if (model) {
      process.stdout.write(model);
    }
  } catch {
    // Fail gracefully
  }
});

---
name: pi-harness-extension
description: Build extensions for the Pi coding agent harness. Make sure to use this skill whenever the user mentions writing, modifying, debugging, or configuring a Pi harness extension, or when working in directory structures matching Pi extension patterns like `.pi/extensions` or `~/.pi/agent/extensions`.
---

# Pi Harness Extensions

This skill guides you through building, configuring, and structuring extensions for the Pi coding agent harness.

## Extension Styles

Choose the appropriate style based on complexity:

### 1. Single File Style
Use this for simple extensions with minimal logic.
Store the extension at `~/.pi/agent/extensions/<name>.ts` for global scope.
Alternatively, store it at `.pi/extensions/<name>.ts` for project-local scope.

### 2. Directory with index.ts Style
Use this for multi-file extensions without external npm dependencies.
Store the files in a subdirectory:
- Entry point: `~/.pi/agent/extensions/<name>/index.ts` (exports default function)
- Helper module: `~/.pi/agent/extensions/<name>/tools.ts`
- Helper module: `~/.pi/agent/extensions/<name>/utils.ts`

### 3. Package with Dependencies Style
Use this when your extension requires third-party npm dependencies.
Structure the directory as follows:
- Package manifest: `~/.pi/agent/extensions/<name>/package.json`
- Package lock: `~/.pi/agent/extensions/<name>/package-lock.json`
- Source files: `~/.pi/agent/extensions/<name>/src/index.ts`
Add required dependencies to `dependencies` in `package.json`.
Run `npm install` inside the extension directory.
Configure the entry point in `package.json` under the `pi` field:
```json
{
  "name": "my-extension",
  "dependencies": {
    "zod": "^3.0.0",
    "chalk": "^5.0.0"
  },
  "pi": {
    "extensions": ["./src/index.ts"]
  }
}
```

## Basic Structure

Extensions must export a default function receiving `ExtensionAPI`:
```typescript
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

export default function (pi: ExtensionAPI) {
  // Register tools, commands, shortcuts, flags here
}
```

### Async Factory Functions
If you need to perform startup work like fetching remote config or discovering models, use an async default function:
```typescript
export default async function (pi: ExtensionAPI) {
  // Async initialization
}
```

### Long-Lived Resources
Never start background resources (timers, socket connections, processes) directly in the factory function.
Defer resource initialization until `session_start` or the event/command that requires them.
Always register an idempotent `session_shutdown` handler to clean up resources.

## Key APIs and Events

- Listen to events: `pi.on("session_start", ...)`
- Register tools: `pi.registerTool({ ... })`
- Register commands: `pi.registerCommand("name", { ... })`
- Interact with the user: `ctx.ui.confirm`, `ctx.ui.notify`
- Access working directory: `ctx.cwd`
- Get session state: `ctx.sessionManager`
- Cancel operations: `ctx.signal`

## Development and Testing

Test extensions locally using the `-e` or `--extension` flag:
```bash
pi -e ./my-extension.ts
```

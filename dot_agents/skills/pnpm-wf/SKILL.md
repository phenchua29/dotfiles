---
name: pnpm-wf
description: >-
  Use pnpm instead of npm for package management in JavaScript/Node.js projects or general situations.
  Only use npm when the project already uses npm (has package-lock.json or explicitly
  uses npm commands). TRIGGERS - pnpm, npm, package.json, node_modules, install dependencies,
  add package, remove package, update dependencies, run script.
allowed-tools: Bash
---

# pnpm Workflows

> **Self-Evolving Skill**: This skill improves through use. If instructions are wrong,
> parameters drifted, or a workaround was needed — fix this file immediately, don't defer.
> Only update for real, reproducible issues.

## When to Use This Skill

Use this skill when working with JavaScript/Node.js projects and the user wants to:
- Install dependencies
- Add or remove packages
- Update dependencies
- Run npm scripts
- Manage package-lock.json vs pnpm-lock.yaml

**Decision Logic**: Check if the project already uses npm before defaulting to pnpm.

## Project Detection

Before running any package management command, check what the project uses:

```bash
# Check if project uses npm
ls package-lock.json 2>/dev/null && echo "npm project" || echo "not npm or pnpm project"

# Check if project uses pnpm
ls pnpm-lock.yaml 2>/dev/null && echo "pnpm project" || echo "not pnpm project"

# Check package manager in package.json (pnpm adds this field)
jq -r '.packageManager // empty' package.json 2>/dev/null
```

## Command Mapping

| npm Command | pnpm Equivalent | Notes |
| ----------- | --------------- | ----- |
| `npm install` | `pnpm install` | pnpm is faster and uses less disk space |
| `npm install <pkg>` | `pnpm add <pkg>` | |
| `npm install -D <pkg>` | `pnpm add -D <pkg>` | or `pnpm add -d <pkg>` |
| `npm uninstall <pkg>` | `pnpm remove <pkg>` | |
| `npm update` | `pnpm update` | pnpm update also updates lockfile |
| `npm run <script>` | `pnpm <script>` | pnpm allows omitting `run` |
| `npm exec <cmd>` | `pnpm exec <cmd>` | run locally installed binary |
| `npx <cmd>` | `pnpm dlx <cmd>` | download and execute package without installing |
| `npm audit` | `pnpm audit` | |
| `npm outdated` | `pnpm outdated` | |

## Migration from npm to pnpm

If starting fresh with a project that has neither lockfile:

```bash
# Check for .npmrc or npmrc field in package.json
grep -r "package-manager" package.json .npmrc 2>/dev/null || echo "no npmrc found"

# Remove node_modules and package-lock.json (if exists) before switching
rm -rf node_modules package-lock.json 2>/dev/null

# Install with pnpm
pnpm install
```

## Workspace Support

pnpm has built-in monorepo support. If `pnpm-workspace.yaml` exists:

```bash
# List workspace packages
pnpm -r list

# Install in all workspace packages
pnpm install --recursive

# Run script in all packages
pnpm -r <script>
```

## Common Patterns

### Install dependencies
```bash
pnpm install
```

### Add package (production dependency)
```bash
pnpm add <package-name>
```

### Add package (dev dependency)
```bash
pnpm add -D <package-name>
```

### Remove package
```bash
pnpm remove <package-name>
```

### Update packages
```bash
pnpm update
```

### Run a script
```bash
pnpm <script-name>
```

### Execute a package without installing
```bash
pnpm dlx <package-name>
```

## pnpm Configuration

View configuration:
```bash
pnpm config list
```

Set configuration:
```bash
pnpm config set <key> <value>
```

## Store Management

pnpm uses a global store for efficiency. Manage it with:

```bash
# View store location
pnpm store path

# Clean store (remove unreferenced packages)
pnpm store prune

# Check for missing dependencies
pnpm store status
```

## Troubleshooting

| Issue | Cause | Solution |
| ----- | ----- | -------- |
| Command not found | pnpm not installed | Install via `curl -fsSL https://get.pnpm.io/install.sh \| sh -` |
| Permission denied | Store permissions | Run `pnpm store prune` or check store path |
| Missing node_modules | Wrong package manager | Check for lockfile, remove conflicting one if needed |
| Script not found | Using npm instead of pnpm | Use `pnpm <script>` instead of `pnpm run <script>` |

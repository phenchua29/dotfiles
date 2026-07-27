---
name: ao
description: "Orchestrator for parallel multi-agent work. ALWAYS use this skill whenever the user asks to get MULTIPLE things done at once, split work into tasks, dispatch workers/agents, delegate parallel work, or coordinate several independent pieces of work. Also triggered by: '/ao', 'orchestrate', 'dispatch', 'parallel', 'create task', 'delegate', 'split this'. If the user lists 2+ tasks, this skill applies. Do NOT skip this skill — it converts multi-request prompts into proper parallel agent workflows via Herdr."
---

# AO — Agent Orchestrator

You act as a lead engineer who decomposes work into parallel sub-tasks and dispatches agents via Herdr. You do **not** write code yourself — your job is coordination.

## Prerequisites

You must be inside Herdr (`HERDR_ENV=1`). Load the `herdr` skill for the exact CLI commands — this skill only covers orchestration logic.

## Workflow

### 1. Plan & decompose

Read the user's request. Build a **task graph** identifying which tasks are parallel and which have dependencies.

- **Parallel tasks** — no shared state or ordering constraints. Dispatch all at once.
- **Dependent tasks** — B needs output or side-effects from A. Mark the dependency.

Each task must be self-contained enough that an agent can run it without asking questions.

For dependent chains, use a **serial dispatch** pattern:

```bash
# Wave 1: dispatch A, wait for completion
worker1=$(herdr pane split --current --direction right --cwd "$PWD" --no-focus | jq -r '.result.pane.pane_id')
herdr agent start task-a --kind opencode --pane "$worker1"
herdr agent prompt task-a "Build task A. Detailed instructions..." --wait --timeout 120000
output_a=$(herdr agent read task-a --source recent-unwrapped --lines 120)

# Wave 2: pass context from A to B
worker2=$(herdr pane split --current --direction right --cwd "$PWD" --no-focus | jq -r '.result.pane.pane_id')
herdr agent start task-b --kind opencode --pane "$worker2"
herdr agent prompt task-b "Using results from A: $output_a. Build task B..." --wait --timeout 120000
herdr agent read task-b --source recent-unwrapped --lines 120
```

### 2. Decide: worktree or not?

- **No worktree needed** — read-only research, docs, small fixes → dispatch a pane in the current tab
- **Worktree needed** — anything that modifies files, creates branches, or needs Git isolation → use `herdr worktree create`

Why worktrees? Agents working in parallel on different branches would conflict in a single checkout. Worktrees give each agent its own isolated working directory and independent branch, so they can commit, push, and PR without stepping on each other.

Each worktree gets its own workspace and tab automatically — `herdr worktree create` returns `workspace`, `tab`, and `root_pane`.

### 3. Create worktree (for isolated tasks)

Use conventional commit prefixes for branch names: `feat/`, `fix/`, `docs/`, `chore/`, etc.

Defaults to forking from HEAD (current branch). If the user explicitly asks for a different base, pass `--base <branch>`:

```bash
herdr worktree create --branch <prefix>/<task-name> --label "<task-name>"           # defaults to HEAD
herdr worktree create --branch <prefix>/<task-name> --base master --label "<task-name>"  # explicit base
```

Save the response fields: `workspace.workspace_id`, `tab.tab_id`, `root_pane.pane_id`, and `worktree.path`.

### 4. Dispatch an agent

Split a pane in the worktree's workspace, name the agent descriptively, and submit the task:

```bash
herdr pane split <root-pane-id> --direction right --cwd <worktree-path> --no-focus
herdr agent start worker-task --kind opencode --pane <new-pane-id>
herdr agent prompt worker-task "<detailed task instructions>" --wait --timeout 120000
```

Why `--no-focus`? It keeps the user's view in your pane, not jumping to each worker as you start them.

Default agent kind is `opencode`. Use other kinds if the user specifies one. List available kinds with `herdr agent`.

For non-worktree tasks in the current tab:

```bash
herdr pane split --current --direction right --cwd "$PWD" --no-focus
herdr agent start worker-x --kind opencode --pane <new-pane-id>
```

### 5. Monitor

`agent prompt --wait` handles the full lifecycle: it submits the task and waits for the agent to reach a settled state (`idle`, `done`, or `blocked`). Use `--timeout` to bound the wait.

#### Normal completion

Terminal viewports are small (25 rows). Long agent output gets clipped. For large results, have the agent write to a shared file path (e.g. `/tmp/<task-name>-output.md`) that the orchestrator can read after the agent finishes:

```bash
herdr agent prompt <name> "... Write the full results to /tmp/<name>-output.md" --wait --timeout 120000
cat /tmp/<name>-output.md
```

For shorter output, read directly from the agent:

```bash
herdr agent read <name> --source recent-unwrapped --lines 120
```

#### Error recovery on stall

If `agent prompt --wait` returns `agent_prompt_stalled` (no state change within 5s):

```bash
herdr agent get <name>
herdr agent read <name> --source recent-unwrapped --lines 120
```

- `blocked` → the agent needs input. Send clarification: `herdr agent prompt <name> "<clarification>" --wait`
- `idle` or `done` → the agent finished already. Read the output.
- `unknown` → agent wasn't detected. Restart: `herdr agent start <name> --kind opencode --pane <pane-id>`

#### If the wait times out but the agent is still working

```bash
herdr agent get <name>
```

- `working` → extend the wait: `herdr agent wait <name> --timeout 300000`
- `blocked` → provide input, then resume waiting
- `idle` or `done` → read the output

#### idle vs done

Both `idle` and `done` mean the agent finished. `done` means the result is unseen (background tab), `idle` means it was seen. Whenever a wait is inconclusive, check `agent get` — if you see either `idle` or `done`, the task is complete.

### 6. Cleanup (when asked)

Remove the worktree and local branch after pushing or when done:

```bash
herdr worktree remove --workspace <workspace-id> [--force]
git branch -D <branch-name>
```

`herdr worktree remove` takes `--workspace <ID>`, not `--branch`. Use `--force` if the worktree has uncommitted changes.

### 7. Aggregate & report

Once all tasks complete, summarize results for the user. Report what each task produced, any failures, and next steps. Do not merge PRs or clean up worktrees unless asked.

## Conventions

- One worktree per task (when isolation is needed) — `herdr worktree create` gives each its own workspace/tab
- One agent per pane, named `worker-<name>` or `review-<name>` so you can tell at a glance
- Default agent kind: `opencode`. Override if user specifies another.
- Use the `herdr` skill for exact CLI syntax — this skill only defines orchestration logic

---
name: github-force-cancel
description: Use the correct GitHub REST API endpoint when the user asks to cancel or force cancel a GitHub Actions run. The force-cancel endpoint is different from the regular cancel endpoint.
---

When the user asks to cancel a GitHub Actions run, pick the correct endpoint based on whether they use the word **"force"**.

## Decision Rule

| User says | Endpoint to use |
|---|---|
| "cancel the run" / "stop the run" | `POST /repos/{owner}/{repo}/actions/runs/{run_id}/cancel` |
| "**force** cancel" / "**force** kill" / "**force** stop" / "hard cancel" | `POST /repos/{owner}/{repo}/actions/runs/{run_id}/force-cancel` |

## How to Cancel (regular)

```bash
gh api -X POST repos/{owner}/{repo}/actions/runs/{run_id}/cancel
```

## How to Force Cancel

```bash
gh api -X POST repos/{owner}/{repo}/actions/runs/{run_id}/force-cancel
```

### Example

```bash
# Regular cancel
gh api -X POST repos/Carl-Johnsons/tastopia/actions/runs/27405381532/cancel

# Force cancel
gh api -X POST repos/Carl-Johnsons/tastopia/actions/runs/27405381532/force-cancel
```

A successful response returns an empty JSON object `{}`.

## Notes

- The regular `cancel` endpoint sends a graceful cancellation signal and may not immediately stop a stuck run.
- The `force-cancel` endpoint **immediately terminates** the run without waiting for jobs to clean up.
- GitHub may require the run to be in a cancellable state (e.g., `in_progress`) for either endpoint to work.

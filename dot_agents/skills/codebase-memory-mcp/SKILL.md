---
name: codebase-memory-mcp
description: >-
  Use this skill to guide the agent on using codebase-memory-mcp CLI mode
  for code discovery and navigation.
---

# Codebase Knowledge Graph (codebase-memory-mcp)

This project uses codebase-memory-mcp to maintain a knowledge graph of the codebase.
The tool operates locally and allows structural querying of the codebase.
ALWAYS prefer CLI mode over grep/glob/file-search for code discovery when structural knowledge is needed.

## CLI Mode Commands

To interact with the knowledge graph, execute the codebase-memory-mcp CLI command.
The general format is:
`codebase-memory-mcp cli <command_name> '<json_arguments>'`

Here are the key commands available:

1. **`list_projects`** - List all indexed projects.
   ```bash
   codebase-memory-mcp cli list_projects '{}'
   ```
2. **`get_architecture`** - Get high-level summary of a project.
   ```bash
   codebase-memory-mcp cli get_architecture '{"project": "<project_name>"}'
   ```
3. **`search_graph`** - Find functions, classes, routes, or variables by pattern.
   ```bash
   codebase-memory-mcp cli search_graph '{"project": "<project_name>", "name_pattern": ".*Handler.*"}'
   ```
4. **`trace_path`** - Trace callers or callees of a function.
   ```bash
   codebase-memory-mcp cli trace_path '{"project": "<project_name>", "function_name": "OrderHandler", "direction": "inbound"}'
   ```
5. **`get_code_snippet`** - Read specific function/class source code.
   ```bash
   codebase-memory-mcp cli get_code_snippet '{"project": "<project_name>", "qualified_name": "pkg/orders.OrderHandler"}'
   ```
6. **`query_graph`** - Run Cypher queries for complex patterns.
   ```bash
   codebase-memory-mcp cli query_graph '{"project": "<project_name>", "query": "MATCH (n) RETURN n LIMIT 10"}'
   ```
7. **`index_repository`** - Index a repository.
   ```bash
   codebase-memory-mcp cli index_repository '{"path": "/absolute/path/to/repo"}'
   ```

## When to fall back to grep/glob

- Searching for string literals, error messages, or configuration values.
- Searching non-code files (Dockerfiles, shell scripts, configs).
- When CLI queries return insufficient results.

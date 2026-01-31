---
allowed-tools: bash, read, write
description: Example command template showing how to create custom OpenCode commands
---

# Example Command

This is an example command template that demonstrates how to create custom OpenCode commands.

## What are Commands?

Commands are custom instructions you can invoke in OpenCode using the `/command-name` syntax. They provide:
- Predefined workflows and procedures
- Consistent execution patterns
- Reusable automation tasks

## Command Structure

### Front Matter (Required)

```yaml
---
allowed-tools: bash, read, write, notion_*, linear_*
description: Brief description of what this command does
---
```

- **allowed-tools**: List of tools the agent can use (comma-separated)
- **description**: Short description shown in command listings

### Command Body

The markdown body contains:
1. **Title**: Main command name
2. **Instructions**: Step-by-step tasks for the agent to follow
3. **Examples**: Usage examples and expected outputs
4. **Notes**: Additional context and edge cases

## Task Instructions

When this example command is invoked, perform these steps:

### 1. Greet the User

Display a welcome message explaining what this command does.

### 2. Demonstrate File Operations

- Read a file using the Read tool
- Create a new file using the Write tool
- Execute a bash command to list files

### 3. Show Results

Display the results of the operations to the user.

## Example Usage

```bash
# Invoke this example command
/example-command

# With arguments (if your command supports them)
/example-command --option value
```

## Output Example

```
Welcome! This is the example command.

I've demonstrated:
- Reading files
- Writing files
- Running bash commands

Your custom command can do much more!
```

## Tips for Creating Commands

1. **Be Specific**: Write clear, step-by-step instructions
2. **Use Allowed Tools**: Only specify tools the command needs
3. **Handle Edge Cases**: Account for missing data or errors
4. **Provide Examples**: Show expected inputs and outputs
5. **Document Well**: Explain what the command does and why

## Real-World Command Examples

For more complex examples, see:
- `log-weekly-summary.md.example` - Integrates Linear and Notion data
- `pr.md` - Creates pull requests with git workflow
- `wiki-add.md` - Adds content to wiki systems

## Notes

- Commands are stored in `~/.config/opencode/commands/`
- File must be named `command-name.md`
- Invoke with `/command-name`
- Commands run in the context of the current working directory

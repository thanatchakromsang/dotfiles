---
name: agents-creator
description: Create and configure OpenCode agents in markdown format. Use when the user requests to create a new agent, convert agents from another format, or configure specialized AI assistants for specific tasks and workflows.
---

# OpenCode Agent Creator

Create specialized OpenCode agents with custom prompts, models, and tool access.

## Agent Types

**Primary agents** - Main assistants you interact with directly. Switch using Tab key.
- Handle main conversation
- Configured tool access via permissions
- Examples: Build (all tools enabled), Plan (restricted)

**Subagents** - Specialized assistants invoked for specific tasks.
- Invoked by primary agents or via @ mention
- Task-specific configurations
- Examples: General (full access), Explore (read-only)

## Agent Configuration Format

Agents use markdown frontmatter (YAML) format:

```markdown
---
description: Reviews code for best practices and potential issues
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
---

You are a code reviewer. Focus on security, performance, and maintainability.
```

## Frontmatter Fields

### Required Fields

**description** (required)
- Brief description of what the agent does and when to use it
- Primary triggering mechanism for agent selection
- Example: `"Reviews code for best practices and potential issues"`

**mode** (required for clarity, defaults to "all")
- `primary` - Main interactive agent (Tab to switch)
- `subagent` - Task-specific agent (@ mention or auto-invoked)
- `all` - Can be used as either

### Optional Fields

**model**
- Override model for this agent
- Format: `provider/model-id`
- Examples: `anthropic/claude-haiku-4-20250514`, `openai/gpt-5`
- Primary agents use global config if not specified
- Subagents inherit from invoking primary agent

**temperature**
- Control randomness/creativity (0.0-1.0)
- 0.0-0.2: Focused, deterministic (analysis, planning)
- 0.3-0.5: Balanced (general development)
- 0.6-1.0: Creative (brainstorming)
- Defaults: 0 for most models, 0.55 for Qwen

**maxSteps**
- Maximum agentic iterations before text-only response
- Controls cost by limiting tool use cycles
- Example: `maxSteps: 5`

**hidden**
- Hide subagent from @ autocomplete menu
- Only for `mode: subagent`
- Still invokable via Task tool by other agents
- Example: `hidden: true`

**disable**
- Disable the agent completely
- Example: `disable: true`

### Tool Configuration

Control which tools the agent can access:

```yaml
tools:
  write: true
  edit: true
  bash: true
  read: true
  glob: true
  grep: true
  webfetch: false
  todo: false
```

Wildcards for MCP servers:
```yaml
tools:
  mymcp_*: false  # Disable all tools from MCP server
  write: false
  edit: false
```

### Permission Configuration

Manage tool permissions with `ask`, `allow`, or `deny`:

```yaml
permission:
  edit: ask      # Prompt for approval
  bash: deny     # Disable tool
  webfetch: allow  # No approval needed
```

Bash command-specific permissions:
```yaml
permission:
  bash:
    "*": ask                # All commands need approval
    "git status*": allow    # Specific command allowed
    "git push": ask         # Specific command needs approval
    "rm -rf *": deny        # Specific command denied
```

Task invocation permissions (control which subagents can be invoked):
```yaml
permission:
  task:
    "*": deny                    # Deny all by default
    "orchestrator-*": allow      # Allow specific pattern
    "code-reviewer": ask         # Ask for specific agent
```

## Agent Body Content

The body (after frontmatter) contains system prompt instructions:

- Role and expertise description
- Task-specific guidelines and checklists
- Workflow procedures
- Quality standards
- Communication protocols
- Integration with other agents

Keep instructions clear, actionable, and focused on the agent's specialty.

## File Locations

**Global agents** (all projects):
```
~/.config/opencode/agents/
```

**Project agents** (specific project):
```
.opencode/agents/
```

File naming: Filename becomes agent name (e.g., `review.md` → `review` agent)

## Creation Workflow

### 1. Define Agent Purpose

Determine:
- What tasks will this agent handle?
- When should it be invoked?
- Primary or subagent mode?
- What tools does it need?

### 2. Configure Frontmatter

Create frontmatter with:
- Clear, comprehensive description
- Appropriate mode (primary/subagent)
- Model selection (if needed)
- Tool access requirements
- Permission settings
- Temperature (if specific behavior needed)

### 3. Write System Prompt

Include:
- Role definition and expertise
- Task execution guidelines
- Quality standards and checklists
- Workflow procedures
- Communication patterns
- Integration notes

### 4. Set Appropriate Restrictions

Match tool access to agent purpose:
- **Read-only agents**: Disable write, edit, bash
- **Analysis agents**: Enable read tools, disable modifications
- **Build agents**: Enable all tools as needed
- **Review agents**: Read tools + webfetch, no modifications

### 5. Test and Iterate

- Create agent file in appropriate location
- Test with typical use cases
- Adjust permissions and prompts based on behavior
- Refine description for better triggering

## Common Agent Patterns

### Code Review Agent
```yaml
---
description: Reviews code for quality and best practices
mode: subagent
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
permission:
  bash:
    "git diff": allow
    "git log*": allow
---
Focus on security, performance, and maintainability.
```

### Build Agent
```yaml
---
description: Full development work with all tools enabled
mode: primary
temperature: 0.3
tools:
  write: true
  edit: true
  bash: true
---
Standard agent for development work.
```

### Documentation Agent
```yaml
---
description: Writes and maintains project documentation
mode: subagent
tools:
  write: true
  edit: true
  bash: false
---
Create clear, comprehensive documentation.
```

### Security Auditor
```yaml
---
description: Performs security audits and identifies vulnerabilities
mode: subagent
tools:
  write: false
  edit: false
permission:
  bash:
    "*": deny
    "grep *": allow
---
Focus on identifying security issues.
```

## Best Practices

1. **Description clarity** - Primary trigger for agent selection, be comprehensive
2. **Tool minimalism** - Only enable tools the agent actually needs
3. **Permission appropriateness** - Match permissions to agent purpose and risk
4. **Temperature selection** - Lower for precision, higher for creativity
5. **Prompt specificity** - Clear role definition and task guidelines
6. **Iterative refinement** - Test with real tasks and adjust

## CLI Commands

Create new agent interactively:
```bash
opencode agent create
```

List available models:
```bash
opencode models
```

## Validation Checklist

- [ ] Description is clear and comprehensive
- [ ] Mode is set appropriately (primary/subagent)
- [ ] Tools match agent responsibilities
- [ ] Permissions prevent unintended actions
- [ ] Temperature suits agent purpose
- [ ] System prompt defines role clearly
- [ ] Quality standards are specified
- [ ] File saved in correct location
- [ ] Filename matches desired agent name

## Notes

- Agent-specific config overrides global config
- Users can always invoke subagents via @ mention
- Last matching permission rule wins
- Hidden subagents still accessible via Task tool
- Model format: `provider/model-id`
- Markdown content preserved exactly in body

# OpenCode User Guidelines

## About This File

This is the **user-level** AGENTS.md deployed to `~/.config/opencode/AGENTS.md`.
- Applies globally across all projects for this user
- Contains skills, user preferences, and memory system
- For project-specific guidance, see the project's `AGENTS.md` file

---

# 🧠 Memory System

You wake up fresh each session. These files are your continuity:

## Memory Files

1. **MEMORY.md** - Your long-term memory (main sessions only)
   - Located at `~/.config/opencode/MEMORY.md`
   - Curated knowledge, lessons learned, important context
   - The distilled essence, not raw logs

2. **memory/YYYY-MM-DD.md** - Daily notes (raw logs)
   - Located at `~/.config/opencode/memory/YYYY-MM-DD.md`
   - Raw logs of what happened each day
   - Create `memory/` directory if needed

## Every Session Startup

**Before doing anything else, automatically read:**
1. `memory/YYYY-MM-DD.md` (today's file)
2. `memory/YYYY-MM-DD.md` (yesterday's file)
3. **If in PRIMARY SESSION**: Also read `MEMORY.md`

**Don't ask permission. Just do it.**

## PRIMARY SESSION

### PRIMARY SESSION (Load MEMORY.md)
- Personal development work
- Private conversations

### SHARED CONTEXT (DO NOT load MEMORY.md)
- Discord channels
- Group chats
- Sessions with other people
- Public contexts

**Why?** Security - MEMORY.md contains personal context that shouldn't leak to strangers.

## 📝 Write It Down - No "Mental Notes"!

**Memory is limited — if you want to remember something, WRITE IT TO A FILE**

- "Mental notes" don't survive session restarts. Files do.
- When someone says "remember this" → update `memory/YYYY-MM-DD.md` or relevant file
- When you learn a lesson → update `AGENTS.md`, `TOOLS.md`, or the relevant skill
- When you make a mistake → document it so future-you doesn't repeat it

**Text > Brain 📝**

## Managing MEMORY.md

### When to Update
- Significant events or decisions
- Important thoughts or insights
- Lessons learned from mistakes
- Patterns or preferences discovered
- Project milestones or completions

### How to Maintain
- Review daily files periodically
- Extract what's worth keeping
- Update MEMORY.md with distilled insights
- Keep it organized and scannable
- Remove outdated information

---

# 🛡️ Safety Rules

**Don't exfiltrate private data. Ever.**

- Don't run destructive commands without asking
- `trash > rm` (recoverable beats gone forever)
- When in doubt, ask
- Respect user privacy and data security

---

# 🔧 Update This File

- **Source:** `~/.dotfiles/nixos/profiles/applications/opencode/opencode-memory.md`
- **Deploy:** `home-manager switch --flake .` in `~/dotfiles`
- **Location:** Deployed to `~/.config/opencode/AGENTS.md`

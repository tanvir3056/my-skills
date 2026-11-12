# my-skills

My Claude Code skills.

| Skill | What it does |
|---|---|
| `/voice-grill` | The full grill-with-docs interview, done by voice. A voice assistant interviews you like a product designer taking a brief, in rounds, until every question is answered. Needs Matt Pocock's skills (`grilling`, `domain-modeling`). |
| `/review-tickets` | A fresh-context review of a ticket list before you approve it. Run after `/to-tickets`. |

## Install

```bash
git clone https://github.com/tanvir3056/my-skills ~/my-skills && bash ~/my-skills/install.sh
```

It links each skill into every Claude account folder on the Mac: `~/.claude`, each `~/.claude-*` account folder, and `$CLAUDE_CONFIG_DIR`. To choose folders yourself, pass them as arguments: `bash ~/my-skills/install.sh ~/.claude-work`. An existing copy is moved to `skills-backup/` first.

## Update

```bash
git -C ~/my-skills pull
```

The skills are links, so a pull updates every account. Start a new Claude session after.

## Add a skill

Add a folder with a `SKILL.md`, commit, push. On other Macs: pull, then run `install.sh` again.

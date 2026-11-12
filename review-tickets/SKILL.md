---
name: review-tickets
description: Independent review of a ticket breakdown before the user approves it. Run after to-tickets shows its proposed list. User-invoked only.
disable-model-invocation: true
---

# Review tickets

Goal: catch a bad ticket breakdown before any ticket is published or built.

## Step 1: Collect

Take the proposed ticket list from this conversation and the path of the spec it came from. If there is no list yet, say so and stop.

## Step 2: Independent review

Start one subagent with fresh context. Give it the ticket list and the spec path only, not a summary of this conversation. Tell it to read the spec and check:

1. Demo: every ticket has a clear answer to "what can I demo when this is done?". The answer must be behaviour, not a layer.
2. Start: the first ticket has no blockers.
3. Edges: every "Blocked by" link is real, and no needed link is missing.
4. Size: no ticket is too small to justify its own agent run, and none is too large for one fresh context window.
5. Collisions: list which tickets become ready at the same time. For each such group, say if they will edit the same files or add the same names. If yes, say which files and names each ticket owns. Parallel work is wanted. It is how large builds finish fast. Keep every blocking edge where one ticket needs what another ticket builds. For tickets that only collide on the same files, first try to give each ticket its own files and names. Add a blocking edge for a collision only when that is not possible.
6. Coverage: nothing in the spec is left without a ticket.

## Step 3: Report

Show the user:
- Problems found, 10 lines or fewer, most serious first. If none, say "No problems found."
- The corrected list, numbered, each ticket with its "Blocked by" line.

## Step 4: Wait

Ask the user to approve the corrected list or change it. Do not publish tickets. After approval, continue the to-tickets flow with the approved list.

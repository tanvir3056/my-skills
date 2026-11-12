---
name: voice-grill
description: The full grill-with-docs interview, done by voice. Builds the complete question tree like grilling, then writes a brief that lets a voice assistant (for example ChatGPT voice) interview the user like a senior product designer taking a brief. Runs in rounds until every question is answered. User-invoked only.
disable-model-invocation: true
---

# Voice grill

Goal: the same depth and the same result as grill-with-docs. Every question in the design tree gets an answer from the user. The only change is the interface: a natural voice conversation instead of numbered questions in the terminal.

You (Claude) build the questions. The voice assistant asks them. You check the answers. Repeat in rounds until nothing is open.

## Step 1: Load the method

Call the Skill tool twice, for "grilling" and "domain-modeling". If the short names fail, use "mattpocock-skills:grilling" and "mattpocock-skills:domain-modeling". Confirm both loaded before you continue. Use their method, with the changes below.

## Step 2: Read the inputs

Read these if they exist:
- The user's idea, as typed after the command, or the file it names.
- docs/product-brief.md. This is the user's own description of the product. Treat it as input, not as settled decisions. Never edit it.
- Every image in docs/inspiration/. Open and look at each one. Read docs/inspiration/links.md if it exists.
- CLAUDE.md, GLOSSARY.md, docs/adr/, docs/design.md, .scratch/<feature-slug>/ and the code.

The feature slug is a short lowercase name with hyphens. For the first version of a new product, use "v1".

If .scratch/<feature-slug>/decisions.md already exists, this is a later round or a resumed session. Continue from it. Do not ask settled questions again.

Fit the depth to the size of the work. A new product or a large change needs the full tree and usually two or more rounds. A small change (one sentence, one demo) needs only the branches it touches, and one round is usually enough.

## Step 3: Image check

If the product has a screen and docs/inspiration/ has no images, stop. Tell the user to put 5 to 8 screenshots of target screens in docs/inspiration/, named by source and screen (for example finch-today.png). Then wait. Agents design well from pictures and poorly from names.

If the user says to continue without images, continue. Then the look-and-feel branch needs more questions.

## Step 4: Build the full design tree

Follow grilling: map every decision and the decisions that hang off it. Do not cap the number. Do not decide anything for the user.

Find facts yourself (repo, brief, images, environment), as grilling says. A fact is never a question.

Cover every branch that applies:
- Vision: what it is, who it is for, the problem, why now, what success looks like.
- Users and their jobs: who, in what situation, how often, what they do today instead.
- Scope: what is in version 1, what is out, what comes later.
- Behaviour: each feature and its rules, edge cases, limits.
- Screens and flow: the list of screens, navigation between them, first-time use, empty states, errors, loading.
- Data: what is stored, for how long, what happens on delete, privacy.
- Look and feel (only if the product has a screen): which image is the target for which screen, what to take and avoid from each image, the feel in three words, light or dark or both, phone or desktop first, how dense, motion, tone of the words on screen.
- Technical defaults: stack, storage, platform, hosting, tests. Write a recommended answer for each. These are asked as one short group, so the user confirms or changes them quickly.
- Terms: every vague or overloaded word in the brief or the idea. Follow domain-modeling: each needs a precise meaning from the user.

Give every question an ID: a short branch prefix and a number, for example V1, U3, S2, B7, F4, D2, L5, T1, G2.

## Step 5: Pick the round

The frontier is every question whose prerequisites are settled (grilling). Round 1 is the frontier. For each frontier question, also write its likely follow-ups as conditions ("if the user says A, also learn X"), so one voice session covers as much of the tree as possible.

If the round has more than 30 questions, split it into sessions by branch (for example session 1: vision, users, scope; session 2: screens and look). Tell the user how many sessions this round has.

## Step 6: Write the brief

Write .scratch/<feature-slug>/round-<N>-brief.md (one file per session if the round is split). It must work alone in a voice assistant that knows nothing about this project and cannot see the images.

First line, before anything else:
"After you read this, reply only with: Ready. Start voice mode when you are. Then wait for me."

Then these sections, in this order. Write them for the voice assistant, in plain words.

1. Who you are:
"You are a senior product designer. I am your client, and you are taking the brief for a software product. Your job is to understand my vision in full and to get a clear answer to every question in the checklist below. Talk like a person, not like a form."

2. How to talk:
"The checklist below is long on purpose. Do not work through it item by item. Cover it the way a good designer does: ask broad questions that make me talk a lot, and pull many answers out of what I say.

Work in this loop, topic by topic:
a. Open: ask one broad question from the openers for this topic. Make me tell a story or describe a real moment, not give a one-word answer.
b. Listen: let me talk. Use short prompts to keep me going: 'and then?', 'why?', 'what would that look like?'.
c. Harvest: silently tick off every checklist question my answer covers, even ones from other topics.
d. Read back: in a few sentences, tell me the answers you took from what I said, and ask me to confirm or correct them. One 'yes' from me can confirm many answers.
e. Dig: for the questions this topic still has open, ask a new broad question that covers several of them at once. Ask a narrow, direct question only for what is still left after that.
Then move to the next topic.

Rules:
- One question at a time. Keep your turns short. I do most of the talking.
- Never read out question IDs, numbered lists or 'option 1, option 2'.
- Ask for real examples: 'walk me through the last time you...', 'what happens right after that?', 'show me with an example'.
- When I use a vague word, like 'simple', 'clean' or 'smart', ask what it means to me, with an example.
- Be relentless, like a good designer. When an answer is thin, dig until it is concrete. When two answers conflict, point it out and ask which one is true.
- Follow my energy. If I jump to a topic, go there, harvest what you can, then come back.
- If I am stuck, offer two or three concrete examples to react to. Give your recommendation only if I ask or am still stuck. Never push it.
- Do not give advice, plans or solutions unless I ask.
- Use only what I say in this conversation. Do not use what you remember about me from other conversations.
- A question is answered only when I said the answer, or I confirmed one you read back to me. A guess you did not read back is not an answer.
- This is the most important step of the project. It can take a long time. That is fine. Do not rush, and never skip a question to save time."

3. Context: 3 to 5 sentences on what is being built. In a later round, add a short list of what is already decided, so the voice assistant does not ask it again.

4. Images: only if there are images. One line per image: its file name and what it shows, in plain words, so we can talk about it by name.

5. Terms to pin down: each vague word and why it needs a precise meaning. If GLOSSARY.md exists, add each glossary term the user is likely to use, with its current meaning: "If I use this word with a different meaning, point it out and ask which one I mean."

6. Checklist: every question of this session, grouped by branch (topic). Start each topic with 2 or 3 openers: broad, story-style questions that together can cover most of the topic's questions. After each opener, list the question IDs it is meant to cover. Write openers that a good designer would ask, for example "Walk me through a day when you would reach for this app" or "Picture the first time someone opens it. What do they see, and what do they feel?".
   Then, for each question:
   - ID and what we need to learn, in one line.
   - Why it matters, in one line.
   - Follow-ups and conditions.
   - Recommended answer, marked "only if asked or stuck".
   The technical defaults are one group: "Near the end, tell me these defaults in one or two sentences and ask if I want any changed."

7. Checkpoints: "If I say 'checkpoint', write the ANSWERS block for everything so far, then continue. If the call drops, I paste that block back to you and we continue from there."

8. Ending:
"Before you end, go through the checklist silently. For every question I have not answered, ask it now, in the same natural way. For every answer you worked out yourself, read it back to me and ask me to confirm or correct it. Do not end until every question is answered.
Then write a final block that starts with the line ANSWERS. For each question, write: the ID, the answer in one or two sentences, the status, and a short quote of my own words where there is one. Status is STATED (I said it) or CONFIRMED (I agreed to what you read back). Then list: new topics I raised that the checklist did not have, anything I contradicted, and any question still open with the reason. Tell me to copy the whole block."

## Step 7: Hand over

Copy the brief to the clipboard with pbcopy. Tell the user in 3 lines: the brief is on the clipboard, paste it into the voice assistant, wait for "Ready", talk, then paste the ANSWERS block back here. Then stop and wait. Do not build anything.

## Step 8: Take the answers

When the user pastes an ANSWERS block:
1. Save it as is to .scratch/<feature-slug>/round-<N>-answers.md. The user's exact words are kept there.
2. Check coverage. Every question ID of the session must have an answer with status STATED or CONFIRMED. An answer without a status, or marked INFERRED, is not answered.
3. Record each answered decision in .scratch/<feature-slug>/decisions.md, grouped by branch, with its ID. Put look and feel under its own heading, with the image names it refers to. docs/design.md is written later from this file.
4. If the spoken answers conflict with docs/product-brief.md, the spoken answers win. List each conflict in decisions.md and in the summary. If an answer says how something works and the code disagrees, that contradiction is a new question for the next round (domain-modeling).
5. Follow domain-modeling for the docs: update GLOSSARY.md with each resolved term (terms only, no decisions, no implementation detail). Write an ADR only for a choice that is hard to reverse, surprising without context, and the result of a real trade-off.
6. Commit.
7. Recompute the frontier: unanswered questions, conflicts, new topics the user raised, and questions that the answers unblocked.

## Step 9: Next round or done

If the frontier is not empty, tell the user how many questions are open and offer two ways:
- Voice: write round <N+1> and go back to Step 6. The brief lists only the open questions plus a short summary of what is decided.
- Text: if 5 or fewer questions are open, ask them here in the grilling round format, each with a recommended answer.

Never end with an open question. A question can close only with the user's answer.

When the frontier is empty, give a summary of 15 lines or fewer: the vision in one line, the main decisions, look and feel, conflicts with the product brief, and the number of rounds. Ask the user to confirm the understanding is shared. After they confirm, say what comes next: "/prototype" if a screen of version 1 has no target image, else "Ready for docs/design.md, then /to-spec." Do not start building.

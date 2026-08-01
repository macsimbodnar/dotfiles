# Global instructions

<!--
Synced via dotfiles: ~/.claude/CLAUDE.md -> ~/ws/dotfiles/claude/CLAUDE.md
Loaded at the start of every session, every project, every machine.
Keep under ~200 lines. Shorter files are followed more reliably.
Project specifics belong in that project's ./CLAUDE.md.
HTML comments are stripped before Claude sees this file.
-->

## Output style

Compact and information dense. Short sentences, simple English, no filler.
Compress wording, never content. Losing information is worse than being long.

Lead with the result. No preamble, no closing summary, no recap of a diff I can read.

Report critical facts first, one line each, even when I did not ask:

- a command, build, or test failed
- an assumption I did not confirm
- data overwritten, deleted, or generated
- deviation from what I asked
- anything that will break later

Explain only when I ask, or when a real tradeoff was made. Then one or two sentences,
not a section.

## Ambiguity

If two readings of my request produce materially different work, stop and ask before
writing code. Do not guess to keep momentum.

For low stakes details (naming, file placement, formatting) pick one and move on.

## Plan before code

If a task touches more than one file, or I described it in one sentence: state the plan
first. Files to change, approach, how it gets verified. Wait for my go ahead.

One goal per change. Keep diffs small and reviewable. No drive-by refactors, renames,
or reformatting outside the task.

## Verify

Do not call work done without running something that proves it: build, test, or script.
If nothing was run, say so in one line.

Never edit or weaken a test to make it pass. If a test looks wrong, stop and tell me.
Never swallow errors, catch and ignore, or hardcode a value to get green output.

## Git

Each project should have his own configuration. If no configuration ask what I prefer.
Usually i prefer agents to commit but not push.

## Dependencies

Never add a dependency on your own. Say what it buys and what writing it by hand costs,
then let me decide.

## Code

snake_case for names unless the language or project convention says otherwise.
Match surrounding style over any general preference.

Comment why, not what. No comment that restates the line below it.

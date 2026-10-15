# AGENTS.md

- Do not commit or push changes without explicit user request and/or permission.
  - If the user _does_ ask you to commit changes:
    - Under any circumstances add a `Co-Author: ...` trailer in `git commit` messages
    - Avoid putting extra cruft in commit trailers
- Keep replies concise, directed, and focused; avoid overly verbose replies
  - I prefer asking follow-up questions to reading long answers.
- When explaining, start from the mechanism and build outward, one layer per reply. I will ask when I need the big picture first.

## Engineering principles

- Introduce an abstraction for an observed need, not merely a possible future use.
- Only add comments which are valuable/high-signal -- the code should be understandable enough to be somewhat self-documenting
  - Do not add narration comments, or document historical decisions in comments

## Documentation

- Do not needlessly document application internals; instead focus on the external contract the user interfaces with
- Avoid phrases like "this release" that will immediately drift -- this information belongs in a `CHANGELOG.md`

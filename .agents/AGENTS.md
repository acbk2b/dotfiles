# AGENTS.md

- Do not commit or push changes without explicit user request and/or permission.
  - If the user _does_ ask you to commit changes:
    - Under any circumstances add a `Co-Author: ...` trailer in `git commit` messages
    - Avoid putting extra cruft in commit trailers
- Keep replies concise, directed, and focused; avoid overly verbose replies
  - I prefer asking follow-up questions to reading long answers.
- When I ask to explain something, do not automatically implement a fix

## Security

- **Under no circumstances** read credentials, `.env` + vault files, etc

## Engineering principles

- Introduce an abstraction for an _observed_ need, not merely a possible future use.
- Only add comments which are valuable/high-signal -- the code should be understandable enough to be somewhat self-documenting
  - Do not add narration comments, or document historical decisions in comments
- Apply the Rule of Three when considering abstractions
  - Note 2 occurrences, consider an abstraction for 3 occurrences (if all occurrences are sufficiently similar)
- Prefer to _remove_ code rather than add new code
- Avoid complex integration tests, unless their provided coverage outweighs their complexity

## Documentation

- Do not needlessly document application internals; instead focus on the external contract the user interfaces with
- Avoid phrases like "this release" that will immediately drift -- this information belongs in a `CHANGELOG.md`

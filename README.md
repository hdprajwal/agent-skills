# Agent Skills

A collection of AI agent skills installable via [skills.sh](https://skills.sh).

## Skills

| Skill | Description |
|-------|-------------|
| [shadcn-audit](./skills/shadcn-audit) | Audits shadcn components from third-party registries for malicious code before installation |
| [humanize](./skills/humanize) | Removes signs of AI-generated writing from text to make it sound more natural and human |

## Install

Install a specific skill:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill <skill-name> -g
```

For example:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill shadcn-audit -g
npx skills add https://github.com/hdprajwal/agent-skills --skill humanize -g
```

## What are agent skills?

Agent skills are modular instruction sets that extend what AI agents can do. Each skill is a markdown file that tells the agent when to activate and how to handle a specific task — consistently, every time.

Skills work across any agent that supports the [skills.sh](https://skills.sh) ecosystem.

## Contributing

Contributions are welcome. To add a new skill:

1. Create a directory under `skills/<skill-name>/`
2. Add a `SKILL.md` with name and description frontmatter
3. Add a `README.md` and `metadata.json`
4. Open a pull request

## License

MIT

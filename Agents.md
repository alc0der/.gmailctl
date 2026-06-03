# gmailctl Agent Instructions

This repo manages Gmail filters as code using [gmailctl](https://github.com/mbrt/gmailctl). Configuration is written in Jsonnet and applied to Gmail via the Gmail API.

## Project Structure

- `config.jsonnet` — main entry point; imports all rule modules and declares all labels
- `env.libsonnet` — user-specific values (author name/email, marketing_email, etc.)
- `helpers.libsonnet` — utilities for reading `.txt` blocklists into filter rules
- `gmailctl.libsonnet` — gmailctl standard library
- `*.jsonnet` — rule modules (coldCallers, dmarc, invoices, meetings, topups, etc.)
- `*.txt` — email address blocklists loaded by corresponding `.jsonnet` files

## Workflow

### Validate config syntax
```shell
jsonnet config.jsonnet
```

### Preview changes before applying
```shell
gmailctl diff
```

### Apply changes to Gmail
```shell
gmailctl apply --yes
```
Always use `--yes` — the interactive prompt doesn't work in non-interactive shells.

## Label conventions

- **Flat labels only** — no `/` nesting (e.g. `Invoices`, not `Notifications/Invoices`)
- **Multiple labels over one precise label** — prefer composable flat labels (e.g. `Ads` + `Approved`) rather than committing to a taxonomy
- All labels used in rules must be declared in the `labels:` array in `config.jsonnet`

## Adding a new rule module

1. Create `myrules.jsonnet` that exports an array of `{ filter, actions }` objects
2. Import it in `config.jsonnet`: `local myRules = import 'myrules.jsonnet';`
3. Add any new labels to the `labels:` array in `config.jsonnet`
4. Append `myRules` to the `rules:` array at the bottom of `config.jsonnet`
5. Run `jsonnet config.jsonnet` to validate, then `gmailctl apply --yes` to apply

## Adding emails to a blocklist

Append the address to the relevant `.txt` file:
```shell
echo "spammer@example.com" >> coldcallers.txt
```
Then apply: `gmailctl apply --yes`

## Rule structure reference

```jsonnet
{
  filter: {
    and: [
      { from: 'noreply@example.com' },
      { subject: 'some subject', isEscaped: true },
    ],
  },
  actions: {
    archive: true,
    markImportant: false,
    labels: ['LabelOne', 'LabelTwo'],
  },
}
```

For complex matching, use a raw Gmail query:
```jsonnet
{
  filter: {
    query: 'from:(foo@bar.com) subject:("hello" OR "world")',
  },
  actions: { archive: true, labels: ['MyLabel'] },
}
```

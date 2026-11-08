# app-config

Public, revocable reviewer access codes for my Android apps, served by GitHub Pages.

```
<slug>/config.json  ->  https://schimpf.github.io/app-config/<slug>/config.json
```

```json
{
  "reviewer_code_hash": "<sha256 hex>",
  "reviewer_code_enabled": true,
  "updated": "<ISO 8601>"
}
```

The app fetches the JSON, normalises the typed code (uppercase, spaces and dashes removed),
hashes it with SHA-256 and compares it to `reviewer_code_hash`. Only hashes live here; codes
are random (80 bits), never committed.

## Add an app

```bash
./new-project.sh <slug>
git add <slug> && git commit -m "Add <slug>" && git push
```

## Rotate a code

```bash
./rotate.sh <slug>
git commit -am "Rotate <slug>" && git push
```

Paste the printed code into Play Console → App content → App access.

## Revoke without a new code

Set `"reviewer_code_enabled": false` in `<slug>/config.json`, commit, push.

GitHub Pages caches for about 10 minutes, so changes are not instant.

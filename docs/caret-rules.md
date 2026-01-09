# Caret Rules (Human Guide) | [한글](./caret-rules_ko.md)

This document is a human-readable companion to `.agents/context/caret-rules.json`.
It summarizes how to work on this repo safely, especially in production.

## Scope and Safety
- This is a production host. Prefer minimal, targeted changes.
- Never commit secrets. Do not add `.env*`, `certs/`, `*.pem`, or runtime keys to git.
- Keep runtime `nginx.conf` files untracked; publish `nginx.conf.sample` instead.
- Runtime-critical areas require documentation of changes and intent:
  - `hubs-all-in-one/`
  - `xrcloud-backend/`
  - `xrcloud-frontend/`
  - `xrcloud-nginx/`

## TLS/SSL Handling
- Cert/key files must be real files, not directories.
- Validate with `file` or `openssl x509` when diagnosing TLS issues.
- If restoring from backups, ensure paths align with `.env.prod` and run scripts.

## Submodules
- Use `git submodule update --init --recursive` for fresh clones.
- If a submodule commit is missing upstream, coordinate to push or move to an available commit.

## Documentation
- Keep human docs in `docs/` (Korean and English paired).
- Reference this file from README(s) for visibility.
- For ops history and recovery steps, see `docs/ops-status.md` and `docs/ops-recovery-plan.md`.

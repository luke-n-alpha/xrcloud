# Ops Status (Human Guide) | [한글](./ops-status_ko.md)

Last updated: 2026-01-08

## Current Structure
- Root orchestrates multiple submodules and service repos.
- Runtime stacks:
  - `hubs-all-in-one/` (dialog, reticulum, hubs client/admin, spoke, proxy, db, postgrest, thumbnail)
  - `xrcloud-backend/`
  - `xrcloud-frontend/`
  - `xrcloud-nginx/`

## Production Notes
- This host is live service. Changes must be minimal and reversible.
- `.env*` and `certs/` are not tracked in git; use backups to restore.
- `nginx.conf` files are runtime-critical and should not be modified without a clear plan.
 - In hubs-all-in-one submodules, `.env`, `nginx.conf`, and `certs/` are script-generated; avoid backing up everything.

## Observed Issues (Recent)
- TLS failures occurred in hubs-all-in-one due to broken cert/key mounts.
- Some cert/key paths were directories instead of files, causing NGINX startup failures.
- Submodule pointers were out of sync with upstream in `reticulum` and `spoke`.
 - External HTTPS endpoints reported unstable because hubs-all-in-one containers were not running.
 - Certbot dry-run failed for HTTP-01 challenges (port 80 connection refused).

## Actions Taken
- Restored cert/key files and nginx.conf files from backups.
- Fixed cert/key mounts to point to files, not directories.
- Updated hubs-all-in-one submodule pointers and pushed upstream.
 - Regenerated runtime files via scripts where possible.
 - Fixed deploy hook to copy renewed certs into runtime paths.

## Open Items
- Validate HTTPS endpoints externally.
- Review open-source docs for security-sensitive content (no secrets).
 - Confirm which runtime files should be regenerated vs. backed up.
 - Ensure port 80 serves `/.well-known/acme-challenge/` for Certbot webroot.

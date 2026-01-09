# Ops Recovery Plan | [한글](./ops-recovery-plan_ko.md)

## Goals
- Restore hubs-all-in-one TLS stability.
- Keep production services running with minimal downtime.
- Ensure all changes are documented and safe for open-source release.

## Immediate Steps (TLS)
1) Verify cert/key files exist and are readable (not directories).
2) Ensure cert SANs include `room.xrcloud.app` where required.
3) Restart only affected containers and confirm logs are clean.
4) Prefer regeneration of `.env`, `nginx.conf`, and `certs/` via scripts when available.
5) Back up only minimal required artifacts; avoid wholesale copying of generated files.

## Submodule Integrity
1) Run `git submodule update --init --recursive`.
2) If upstream is missing commits, coordinate to push or move to available commits.
3) Commit parent repo pointer updates and push.

## Documentation
1) Update `docs/ops-status*.md` with findings and actions.
2) Keep `.env*`, `certs/`, keys out of git and public docs.
3) Link human docs from README(s) for visibility.

## Validation
- Check HTTPS endpoints (external).
- Confirm container status and logs are stable.

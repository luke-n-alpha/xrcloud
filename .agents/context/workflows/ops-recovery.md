# ops-recovery (AI)

Goal: restore production safely with minimal changes.

Checklist:
1) Identify failing service and TLS/SSL error source.
2) Verify cert/key are files (not directories) and match expected paths.
3) Restore from backup only if necessary; avoid committing secrets.
4) Restart only affected containers; confirm logs are clean.
5) Document root cause and steps in `docs/`.

# OSS Documentation Review | [한글](./oss-docs-review_ko.md)

## Security Checklist
- No secrets or credentials in docs.
- No `.env*` content, certs, keys, or private endpoints.
- Example configs use placeholders.
- Runtime `nginx.conf` is replaced by `nginx.conf.sample`.
- Generated configs (`reticulum/config/*.exs`, submodule `.env*`) must not be committed if they contain credentials.

## Compliance Checklist
- LICENSE/NOTICE referenced from README.
- Third-party licenses referenced where applicable.
- Submodule origins and licenses are noted.

## Ops Checklist
- Human docs live under `docs/` with Korean/English pairs.
- Links from README(s) verified.

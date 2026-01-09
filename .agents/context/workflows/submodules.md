# submodules (AI)

Goal: keep submodules consistent with upstream.

Checklist:
1) `git submodule update --init --recursive`.
2) If commit is missing upstream, fetch and verify remote.
3) Align to available commit or push missing commit upstream.
4) Commit submodule pointer updates in parent repo.

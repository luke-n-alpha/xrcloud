# Caret 규칙 (사람용 가이드) | [English](./caret-rules.md)

이 문서는 `.agents/context/caret-rules.json`의 사람이 읽는 요약본입니다.
운영 환경에서 안전하게 작업하기 위한 기본 규칙을 정리합니다.

## 범위와 안전
- 이 호스트는 실서비스입니다. 변경은 최소/정확하게 합니다.
- 비밀정보는 커밋 금지: `.env*`, `certs/`, `*.pem`, 런타임 키 파일은 git에 추가하지 않습니다.
- 런타임 `nginx.conf`는 추적하지 않고 `nginx.conf.sample`로 공개합니다.
- 런타임 핵심 영역은 변경 사유와 영향을 문서화합니다:
  - `hubs-all-in-one/`
  - `xrcloud-backend/`
  - `xrcloud-frontend/`
  - `xrcloud-nginx/`

## TLS/SSL 처리
- cert/key는 디렉터리가 아니라 실제 파일이어야 합니다.
- TLS 이슈 진단 시 `file`, `openssl x509`로 파일 타입을 확인합니다.
- 백업 복구 시 `.env.prod`의 경로와 run 스크립트 경로를 반드시 맞춥니다.

## 서브모듈
- 초기화: `git submodule update --init --recursive`
- 원격에 없는 커밋을 가리키면, 커밋 복구/푸시 또는 가용한 커밋으로 정렬합니다.

## 문서화
- 사람용 문서는 `docs/` 아래 한/영문으로 관리합니다.
- README에서 본 문서를 연결해 가시성을 확보합니다.
- 운영 현황/복구 계획은 `docs/ops-status_ko.md`, `docs/ops-recovery-plan_ko.md`를 참고합니다.

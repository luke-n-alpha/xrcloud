# 운영 현황 (사람용 가이드) | [English](./ops-status.md)

최종 업데이트: 2026-01-08

## 현재 구조
- 루트에서 여러 서브모듈/서비스 레포를 조율합니다.
- 런타임 스택:
  - `hubs-all-in-one/` (dialog, reticulum, hubs client/admin, spoke, proxy, db, postgrest, thumbnail)
  - `xrcloud-backend/`
  - `xrcloud-frontend/`
  - `xrcloud-nginx/`

## 운영 주의사항
- 이 호스트는 실서비스입니다. 변경은 최소/가역적으로 진행합니다.
- `.env*`, `certs/`는 git에서 제외되며 백업으로 복구합니다.
- `nginx.conf`는 런타임 핵심 설정이므로 변경 시 계획이 필요합니다.
 - hubs-all-in-one 하위 서브모듈의 `.env`, `nginx.conf`, `certs/`는 스크립트로 생성됩니다. 전체 백업은 지양합니다.

## 최근 문제 요약
- hubs-all-in-one에서 TLS 오류 발생.
- cert/key 경로가 파일이 아닌 디렉터리로 꼬여 NGINX 구동 실패.
- `reticulum`, `spoke` 서브모듈 포인터가 원격과 불일치.
 - 외부 HTTPS 엔드포인트가 hubs-all-in-one 컨테이너 비정상으로 불안정.

## 수행된 조치
- 백업에서 cert/key 및 nginx.conf 복구.
- cert/key 마운트를 파일로 정렬.
- hubs-all-in-one 서브모듈 포인터 업데이트 및 원격 반영.
 - 가능한 경우 스크립트로 런타임 파일 재생성.

## 남은 작업
- 외부 HTTPS 엔드포인트 정상 확인.
- 오픈소스 문서 보안 검토(비밀정보 미포함).
 - 어떤 런타임 파일을 재생성/백업할지 기준 확정.

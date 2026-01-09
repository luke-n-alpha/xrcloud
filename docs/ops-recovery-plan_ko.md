# 운영 복구 계획 | [English](./ops-recovery-plan.md)

## 목표
- hubs-all-in-one TLS 안정화
- 최소 다운타임으로 서비스 유지
- 변경사항 문서화 및 오픈소스 안전성 확보

## 즉시 작업 (TLS)
1) cert/key 파일 존재 및 읽기 가능 여부 확인(디렉터리 금지)
2) cert SAN에 `room.xrcloud.app` 포함 여부 확인
3) 영향 범위만 재시작 후 로그 정상 여부 확인
4) 가능하면 스크립트로 `.env`, `nginx.conf`, `certs/` 재생성

## 서브모듈 정합성
1) `git submodule update --init --recursive` 실행
2) 원격에 없는 커밋은 복구/푸시 또는 가용 커밋으로 정렬
3) 상위 레포 포인터 업데이트 후 푸시

## 문서화
1) `docs/ops-status*.md`에 현황/조치 기록
2) `.env*`, `certs/`, 키 파일은 git/문서에 포함 금지
3) README에서 사람용 문서를 연결

## 검증
- 외부 HTTPS 엔드포인트 확인
- 컨테이너 상태/로그 안정성 확인

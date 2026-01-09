# 오픈소스 문서 검토 | [English](./oss-docs-review.md)

## 보안 체크리스트
- 비밀정보/자격증명 미포함.
- `.env*`, 인증서, 키, 내부 전용 엔드포인트 미포함.
- 예시 설정은 플레이스홀더로 작성.
- 런타임 `nginx.conf`는 `nginx.conf.sample`로 대체 공개.
- 생성된 설정(`reticulum/config/*.exs`, 서브모듈 `.env*`)에 자격증명이 포함되면 커밋 금지.

## 준수 체크리스트
- README에서 LICENSE/NOTICE 연결.
- 필요 시 서드파티 라이선스 표기.
- 서브모듈 출처 및 라이선스 명시.

## 운영 체크리스트
- 사람용 문서는 `docs/` 아래 한/영문 쌍으로 정리.
- README 링크 정상 동작 확인.

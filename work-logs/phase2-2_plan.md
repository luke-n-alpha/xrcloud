# Phase 2-2: 환경 변수 설정 강화 실행 계획

본 문서는 `hubs-all-in-one` 서브모듈에서 발견된 민감 정보 노출 문제를 해결하기 위한 구체적인 실행 계획을 정의합니다.

## 1. 문제 상황

- `hubs-all-in-one/.env.prod` 파일에 운영 데이터베이스 비밀번호(`DB_PASSWORD`)를 포함한 민감한 환경 설정 정보가 그대로 Git 저장소에 커밋되어 있습니다.
- `hubs-all-in-one/.env.sample` 파일에도 실제 사용 가능한 테스트 비밀번호가 포함되어 있어 보안상 안전하지 않습니다.

## 2. 해결 목표

- Git 저장소에서 모든 `.env` 파일의 추적을 완전히 제거합니다.
- 향후 `.env` 파일이 커밋되는 것을 방지하기 위해 `.gitignore` 규칙을 강화합니다.
- 개발자들이 안전하게 환경 설정을 할 수 있도록 `env.sample` 파일을 표준화합니다.

## 3. 실행 절차

### 3-1. 민감 파일(.env.prod) Git 추적 제거

- **명령어:** `git rm --cached hubs-all-in-one/.env.prod`
- **설명:** Git 인덱스에서만 파일을 제거합니다. 마스터의 로컬 개발 환경에 있는 실제 파일은 삭제되지 않으므로, 기존 설정은 그대로 유지됩니다.

### 3-2. .gitignore 파일 강화

- **대상 파일 1:** `hubs-all-in-one/.gitignore`
- **대상 파일 2:** 루트 `.gitignore`
- **추가할 내용:**
    ```
    # Environment variables
    .env*
    *.env
    ```
- **설명:** `.env`, `.env.prod`, `.env.local` 등 `.env`로 시작하거나 끝나는 모든 파일이 향후 커밋되는 것을 방지합니다.

### 3-3. .env.sample 파일 수정

- **대상 파일:** `hubs-all-in-one/.env.sample`
- **수정 내용:** `DB_PASSWORD="xrcloud-dev!"`를 `DB_PASSWORD="changeme"`와 같이 안전한 플레이스홀더로 변경합니다.

---

상기 계획에 따라 작업을 진행하고자 합니다. **마스터의 승인을 기다립니다.**

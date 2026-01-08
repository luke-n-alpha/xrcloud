# Caret 마스터 작업 계획 (v2 - Refactoring 완료)

이 문서는 XRCLOUD 프로젝트의 저장소 리팩토링, AI 협업 환경 구축, 그리고 주요 운영 워크플로우를 기록하기 위한 Caret의 마스터 작업 계획입니다.

## 전체 작업 목록

---

### ✅ **1단계: 프로젝트 구조 및 Git 저장소 재설정 (완료)**

- **목표:** 모노레포 구조를 재설정하고, 모든 서브모듈의 Git 연결을 바로잡아 안정적인 개발 환경을 구축합니다.
- **수행 내역:**
  - [x] `docs/work-logs` 디렉터리 생성 및 마스터 플랜 초기화
  - [x] 메인 `xrcloud` 저장소의 기존 `.git` 삭제 및 신규 `git init`
  - [x] 신규 원격 저장소(`[YOUR_GIT_REMOTE_URL]`) 연결
  - [x] 4개의 핵심 서브모듈 (`backend`, `frontend`, `nginx`, `hubs`) 추가
  - [x] 서브모듈 초기화 (`submodule update --init --recursive`) 과정에서 발생한 모든 충돌 해결
    - [x] `hubs-all-in-one` 내부의 잘못된 서브모듈 URL 수정
    - [x] `reticulum` 서브모듈의 로컬 변경사항(`Dockerfile` 등)을 `git stash`로 보존하며 업데이트 완료

---

### ✅ **2단계: AI 에이전트 협업 환경 초기화 (완료)**

- **목표:** AI 에이전트가 프로젝트의 규칙과 맥락을 이해하고 원활하게 협업할 수 있도록 표준 환경을 구축합니다.
- **수행 내역:**
  - [x] 프로젝트 루트에 `.agents/context` 표준 디렉터리 구조 생성
  - [x] `caret-rules.json` 및 `caret-rules.md` (AI 작업 규칙) 생성
  - [x] `ai-work-index.yaml` (작업 색인) 생성
  - [x] `workflows/` 디렉터리 및 기본 가이드 파일 생성

---

### 🗂️ **3단계: 프로젝트 유지보수 및 운영 워크플로우**

- **목표:** 프로젝트의 안정적인 운영을 위해 필수적인 절차와 해결된 문제들을 명확하게 문서화합니다.

#### **3.1 Letsencrypt 인증서 갱신 및 적용 방법**

- **문제 상황:** `example.com` 및 하위 도메인의 SSL 인증서가 갱신되지 않는 것으로 보임.
- **분석 결과:**
  - 서버(호스트 머신)의 `certbot`은 **인증서 자동 갱신에 성공**하고 있었음. (`sudo certbot certificates` 명령으로 유효기간 확인 가능)
  - 진짜 원인은, 갱신된 인증서 파일이 `xrcloud-nginx` Docker 컨테이너 및 기타 서브모듈로 **복사/적용되지 않았기 때문**.
- **해결 절차:**
  1. **(필요시) 수동 갱신:** `sudo certbot renew` 명령으로 인증서를 수동 갱신할 수 있습니다.
  2. **(필수) 인증서 적용:** `xrcloud-nginx` 서브모듈 디렉터리로 이동합니다.
     ```bash
     cd [PROJECT_ROOT]/xrcloud-nginx
     ```
  3. **`run.sh` 스크립트 실행:** `prod` 모드로 스크립트를 실행하여, 서버의 `/etc/letsencrypt/live/[YOUR_DOMAIN]/`에 있는 최신 인증서 파일들을 프로젝트의 모든 필요한 위치로 복사하고 `xrcloud-nginx` 컨테이너를 재시작합니다.
     ```bash
     ./run.sh prod
     ```
  - **결론:** 인증서 갱신 주기에 맞춰, 또는 갱신 후 `run.sh prod`를 실행하는 것이 필수적인 운영 절차입니다.

---
**작성자:** Caret (Alpha)
**소유자:** Master (Luke)

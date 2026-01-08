# 계획 004: 오픈소스 원칙에 따른 리팩토링

## 1. 목표

모든 문서와 스크립트에서 실제 서비스와 관련된 민감/내부 정보를 제거하고, `.env` 파일을 통한 환경 변수 관리 체계를 도입하여 프로젝트를 완전한 오픈소스 형태로 전환한다.

## 2. 세부 계획

### 2.1. `caret_master_plan.md` 문서 수정

- **내용:**
  - `git@git.belivvr.com:xr/xrcloud.git` -> `[YOUR_GIT_REMOTE_URL]`
  - `/home/belivvr/xrcloud/...` -> `[PROJECT_ROOT_PATH]/...`
  - `xrcloud.app` 및 서브도메인 -> `example.com`, `api.example.com` 등
- **도구:** `replace_in_file`

### 2.2. `xrcloud-nginx` 모듈 .env 관리 체계 도입

- **대상:** `run.sh` 스크립트
- **절차:**
  1. **`.env.sample` 파일 생성:** `run.sh`에서 사용하는 환경 변수(예: `STORAGE_PATH`)에 대한 템플릿을 제공한다.
     ```
     # .env.sample
     
     # Nginx가 접근해야 할 스토리지 경로
     STORAGE_PATH=/path/to/your/storage
     
     # SSL 인증서가 위치한 도메인 이름
     CERT_DOMAIN=example.com
     ```
  2. **`.gitignore` 확인:** `.env` 파일이 포함되어 있는지 확인하고, 없다면 추가한다.
  3. **`run.sh` 수정:** 스크립트 시작 부분에 `.env` 파일을 읽어와 변수를 설정하는 로직을 추가한다.
     ```bash
     if [ -f .env ]; then
       export $(cat .env | sed 's/#.*//g' | xargs)
     fi
     ```
     스크립트 내부의 하드코딩된 값을 `${STORAGE_PATH}`, `${CERT_DOMAIN}` 등으로 교체한다.

### 2.3. 타 모듈 확장

- `xrcloud-nginx` 작업 완료 후, `xrcloud-backend` 등 다른 모듈에도 동일한 절차를 적용하여 환경 변수 관리 체계를 확립한다.

# Nginx 보안 강화 및 복구 계획 (오픈소스 공개 대비)

## 목표
`xrcloud-nginx` 서비스의 SSL 인증서 관리 방식을 개선하여, 오픈소스로 코드를 공개해도 안전한 구조를 만듭니다.

## 현재 구조의 보안 위험
1.  **과도한 권한:** `certbot`의 `renew_hook`이 Git 저장소에 포함된 셸 스크립트(`run.sh`)를 `root` 권한으로 직접 실행합니다. 저장소에 악의적인 코드가 주입될 경우, 서버 최고 권한을 탈취당할 수 있습니다.
2.  **개인키 노출 가능성:** Docker 컨테이너가 호스트의 Let's Encrypt 라이브 디렉토리 (`/etc/letsencrypt/live/`)를 직접 마운트합니다. Nginx나 웹 애플리케이션의 취약점으로 인해 컨테이너 내부 접근을 허용할 경우, 서버의 SSL 개인키가 유출될 위험이 있습니다.

## 보안 강화 솔루션 (마스터 제안 기반)
`root` 권한의 시스템 영역과 애플리케이션 영역을 명확히 분리하고, 인증서 사본을 사용하여 위험을 최소화합니다.

1.  **안전한 갱신 스크립트 생성 (`/usr/local/bin/renew_xrcloud.sh`)**
    - Git 저장소 외부의 안전한 위치에 `root`만 수정 가능한 갱신 스크립트를 생성합니다.
    - 이 스크립트는 다음 작업만 수행합니다.
        a. `/etc/letsencrypt/live/xrcloud.app/`의 인증서 파일들을 `xrcloud-nginx/ssl_live/` 디렉토리로 **복사**합니다.
        b. `xrcloud-nginx` Docker 컨테이너를 재시작하는 `run.sh`를 호출합니다.

2.  **인증서 사본 디렉토리 생성**
    - `xrcloud-nginx/ssl_live/` 디렉토리를 생성하고 `.gitignore`에 추가하여 저장소에 포함되지 않도록 합니다. Docker 컨테이너는 시스템의 원본이 아닌 이 사본 디렉토리를 마운트합니다.

3.  **설정 파일 수정**
    - **`certbot` 갱신 훅:** `/usr/local/bin/renew_xrcloud.sh`를 실행하도록 수정합니다.
    - **`.env.prod`:** `SSL_DIR` 변수가 로컬의 `ssl_live` 디렉토리를 가리키도록 수정합니다.
    - **`nginx.conf`:** `xrcloud.app`과 `api.xrcloud.app` 모두 동일한 인증서 사본을 사용하도록 경로를 수정합니다. (기존의 `frontend`/`backend` 구분은 불필요하므로 제거)

## 다음 단계
마스터께서 위 계획을 승인해주시면, 알파가 이 계획에 따라 단계별로 실행하여 안전한 구조로 서비스를 복구하겠습니다.

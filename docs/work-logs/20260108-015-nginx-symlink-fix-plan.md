# Nginx SSL 인증서 심볼릭 링크 문제 해결 및 자동 갱신 아키텍처 적용 계획

## 1. 개요
마스터의 피드백을 통해 확인된 Let's Encrypt 인증서의 심볼릭 링크 문제를 해결하고, 안정적인 인증서 갱신 및 서비스 운영을 위한 아키텍처를 적용한다. 현재 Nginx 컨테이너는 심볼릭 링크된 인증서 경로를 직접 마운트하여 시작에 실패하고 있다.

## 2. 해결 전략: 인증서 물리적 복사 및 로컬 마운트
`run.sh` 스크립트가 실행될 때, 시스템의 Let's Encrypt 인증서(심볼릭 링크)의 원본 파일을 프로젝트 내부의 `ssl/` 디렉터리로 복사한다. 그 후, Nginx 컨테이너는 외부 경로가 아닌 프로젝트 내부의 복사된 인증서 파일을 마운트하여 사용한다.

## 3. 세부 실행 계획

### 3.1. `xrcloud-nginx/run.sh` 스크립트 수정
- **인증서 복사 로직 추가**: `docker run` 실행 전, `sudo cp -L` 명령어를 사용해 `/etc/letsencrypt/live/xrcloud.app/` 경로의 `fullchain.pem`과 `privkey.pem` 파일을 `xrcloud-nginx/ssl/` 디렉터리로 복사하는 코드를 추가한다.
- **볼륨 마운트 경로 변경**: 기존의 `-v "$SSL_DIR:/etc/ssl"` 마운트 설정을 `-v "$(pwd)/ssl:/etc/ssl"`로 변경하여, 스크립트가 위치한 디렉터리 내의 `ssl` 폴더를 컨테이너에 마운트하도록 수정한다.

### 3.2. `xrcloud-nginx/nginx.conf` 설정 파일 수정
- **SSL 인증서 경로 단순화**: `xrcloud.app`과 `api.xrcloud.app` 서버 블록의 인증서 경로에서 불필요한 하위 디렉터리(`/frontend`, `/backend`)를 모두 제거하고, 컨테이너 내의 최종 경로인 `/etc/ssl/fullchain.pem` 및 `/etc/ssl/privkey.pem`을 바라보도록 수정한다.

### 3.3. 실행 및 1차 검증
- 수정된 `./run.sh prod` 스크립트를 실행한다.
- `docker ps` 명령으로 `xrcloud-nginx` 컨테이너가 `Up` 상태로 정상 실행되는지 확인한다.

### 3.4. 최종 브라우저 검증
- 마스터의 지시에 따라, 아래 URL에 접속하여 서비스가 정상적으로 동작하는지 브라우저를 통해 최종 확인한다.
  - `https://xrcloud.app`
  - `https://api.xrcloud.app`
  - `https://room.xrcloud.app:4000`

## 4. 향후 과제
- `certbot` 갱신 시, 복사된 인증서도 자동으로 업데이트하고 Nginx를 재시작하도록 `/etc/letsencrypt/renewal-hooks/deploy` 스크립트를 설정한다. (본 계획 완료 후 진행)

# SSL/TLS 인증서 갱신 작업 계획: room.xrcloud.app

## 1. 문제 정의
- **현상:** `room.xrcloud.app:4000` 레티큘럼 허브 서비스에 접속할 수 없음.
- **추정 원인:** `room.xrcloud.app` 도메인에 대한 Letsencrypt SSL/TLS 인증서가 만료되었거나 갱신 과정에 문제가 발생함.

## 2. 작업 목표
- Letsencrypt 인증서를 성공적으로 갱신합니다.
- 갱신된 인증서를 웹서버(Nginx)에 적용합니다.
- `room.xrcloud.app` 서비스의 정상 동작을 복구하고 확인합니다.

## 3. Phase 1: 진단 및 현황 분석
**목표:** 문제의 정확한 원인을 파악합니다.

- [ ] **1-1. 서버 환경 확인:**
    - [ ] `ssh`를 통해 서버에 접속합니다.
    - [ ] `docker ps -a` 명령어로 현재 실행 중인 컨테이너 목록과 상태(Nginx, Certbot 관련)를 확인합니다.
- [ ] **1-2. 인증서 상태 점검:**
    - [ ] `openssl s_client -connect room.xrcloud.app:443 -servername room.xrcloud.app | openssl x509 -noout -dates` 명령어를 사용하여 현재 적용된 인증서의 만료일을 직접 확인합니다.
- [ ] **1-3. Certbot 로그 분석:**
    - [ ] Certbot 컨테이너에 접속하거나 볼륨으로 마운트된 로그 파일(`/var/log/letsencrypt/letsencrypt.log`)을 확인하여 최근 갱신 시도 시 발생한 오류 메시지를 찾습니다.
- [ ] **1-4. Nginx 설정 검토:**
    - [ ] Nginx 컨테이너 또는 호스트의 설정 파일(`.../nginx/conf.d/default.conf` 등)을 확인하여 인증서 경로와 챌린지(challenge) 설정(`.well-known/acme-challenge`)이 올바른지 검토합니다.

## 4. Phase 2: 갱신 및 복구
**목표:** 인증서를 갱신하고 서비스를 정상화합니다.

- [ ] **2-1. 테스트 갱신 (Dry-run):**
    - [ ] `docker-compose exec certbot certbot renew --dry-run` 또는 유사한 명령어를 실행하여 실제 갱신 과정에 문제가 없는지 사전 테스트합니다.
- [ ] **2-2. 실제 갱신 실행:**
    - [ ] Dry-run 성공 시, `docker-compose exec certbot certbot renew` 명령어로 실제 갱신을 시도합니다.
    - [ ] (필요 시) 갱신을 위해 Nginx 컨테이너를 일시적으로 중단합니다 (`docker-compose stop nginx`).
- [ ] **2-3. 웹서버 재시작:**
    - [ ] 인증서 갱신 성공 후, `docker-compose restart nginx` 또는 `docker-compose exec nginx nginx -s reload` 명령어로 Nginx가 새 인증서를 불러오도록 합니다.

## 5. Phase 3: 검증
**목표:** 모든 것이 정상적으로 동작하는지 최종 확인합니다.

- [ ] **3-1. 브라우저 테스트:** 웹 브라우저에서 `https://room.xrcloud.app`에 접속하여 자물쇠 아이콘과 인증서 정보를 확인합니다.
- [ ] **3-2. 외부 도구 검증:** [SSL Labs' SSL Test](https://www.ssllabs.com/ssltest/)와 같은 외부 서비스를 사용하여 인증서 체인과 서버 설정의 유효성을 종합적으로 검증합니다.

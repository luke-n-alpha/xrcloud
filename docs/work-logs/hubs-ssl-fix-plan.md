# Hubs All-in-One SSL 인증서 문제 해결 계획

## 1. 문제 원인 요약

`hubs-all-in-one` 스택의 일부 서비스가 SSL 인증서 개인 키 파일(`privkey.pem`)을 올바르게 참조하지 못하여 컨테이너 재시작에 실패하고 있습니다. 원인은 다음과 같이 두 가지로 확인되었습니다.

1.  **`.env.prod` 설정 오류**: 환경 변수를 총괄하는 `.env.prod` 파일의 `SSL_KEY_FILE` 변수가 존재하지 않는 `key.pem`을 가리키고 있으며, 경로 앞에 불필요한 슬래시가 하나 더 포함되어 있습니다.
2.  **`spoke/run.sh` 구현 오류**: `spoke` 서비스의 실행 스크립트가 `.env.prod`를 참조하지 않고, 잘못된 경로와 파일명(`certs/key.pem`)을 직접 하드코딩하여 사용하고 있습니다.

## 2. 수정 대상 파일 및 변경 내용

이 문제를 해결하기 위해 아래 두 개의 파일을 수정합니다.

### 2.1. `hubs-all-in-one/.env.prod`

`SSL_KEY_FILE` 변수의 경로를 `privkey.pem`으로 수정하고, 경로 앞의 이중 슬래시를 단일 슬래시로 수정합니다.

```diff
------- SEARCH
SSL_KEY_FILE="//home/belivvr/xrcloud/hubs-all-in-one/certs/key.pem"
=======
SSL_KEY_FILE="/home/belivvr/xrcloud/hubs-all-in-one/certs/privkey.pem"
+++++++ REPLACE
```

### 2.2. `hubs-all-in-one/spoke/run.sh`

하드코딩된 인증서 경로를 수정하여 상위 디렉토리의 `certs`를 참조하도록 하고, `key.pem`을 `privkey.pem`으로 변경합니다.

```diff
------- SEARCH
    -v $(pwd)/certs/cert.pem:/etc/nginx/certs/cert.pem \
    -v $(pwd)/certs/key.pem:/etc/nginx/certs/key.pem \
=======
    -v $(pwd)/../certs/cert.pem:/etc/nginx/certs/cert.pem \
    -v $(pwd)/../certs/privkey.pem:/etc/nginx/certs/key.pem \
+++++++ REPLACE
```
*참고: 컨테이너 내부 경로인 `/etc/nginx/certs/key.pem`은 Nginx 설정과의 호환성을 위해 유지합니다. 호스트의 `privkey.pem`이 컨테이너 내부로 들어갈 때 `key.pem`으로 이름이 변경되어 마운트됩니다.*

## 3. 예상 결과

위 두 파일을 수정한 후 `hubs-all-in-one/restart_all.sh`를 실행하면, `spoke`와 `proxy`를 포함한 모든 서비스가 정상적으로 SSL 인증서를 로드하여 안정적으로 실행될 것으로 예상됩니다.

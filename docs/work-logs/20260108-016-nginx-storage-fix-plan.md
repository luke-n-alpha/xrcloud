# Nginx 스토리지 경로 문제 해결 계획

## 1. 문제 원인

- `xrcloud-nginx` 컨테이너가 `api.xrcloud.app/storage/*` 경로의 정적 파일을 제대로 제공하지 못하고 있습니다.
- 원인 분석 결과, 컨테이너 실행 시 `-v` 옵션을 통해 마운트하는 호스트의 스토리지 경로(`Source`)가 `/app/xrcloud-backend/storage`로 잘못 설정되어 있었습니다.
- `xrcloud-backend`의 `.env.prod` 파일을 통해 확인한 실제 스토리지 경로는 `/mnt/xrcloud-prod-ko/xrcloud/storage` 입니다.

## 2. 해결 방안

`xrcloud-nginx/run.sh` 스크립트의 `docker run` 명령 부분을 수정하여, 호스트의 실제 스토리지 경로를 컨테이너에 올바르게 마운트하도록 변경합니다.

## 3. 변경 내용

- **파일:** `xrcloud-nginx/run.sh`
- **변경 전:**
  ```bash
  -v "$STORAGE_PATH:/app/xrcloud-backend/storage" \
  ```
- **변경 후:**
  ```bash
  -v "/mnt/xrcloud-prod-ko/xrcloud/storage:/app/xrcloud-backend/storage" \
  ```

## 4. 실행 절차

1.  `replace_in_file`을 사용하여 `xrcloud-nginx/run.sh` 파일을 수정합니다.
2.  `./xrcloud-nginx/run.sh prod` 명령을 실행하여 Nginx 컨테이너를 재시작합니다.
3.  `api.xrcloud.app/storage/` 경로의 리소스가 정상적으로 로드되는지 확인합니다.
